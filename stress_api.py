import cv2
import mediapipe as mp
import numpy as np
from scipy.spatial import distance
from flask import Flask, jsonify
from flask_cors import CORS
import threading
import time

# --- FLASK API SETUP ---
app = Flask(__name__)
CORS(app) # Allow frontend to ping this API

current_status = "NORMAL 🙂"
current_ear = 0.0

@app.route('/status', methods=['GET'])
def get_status():
    global current_status, current_ear
    return jsonify({
        "status": current_status,
        "ear": round(current_ear, 3)
    })

# --- OPENCV WEBCAM THREAD ---
def stress_detection_loop():
    global current_status, current_ear
    
    mp_face = mp.solutions.face_mesh
    face_mesh = mp_face.FaceMesh(refine_landmarks=True)
    
    # Eye landmarks
    LEFT_EYE = [33, 160, 158, 133, 153, 144]
    RIGHT_EYE = [362, 385, 387, 263, 373, 380]

    # Eye Aspect Ratio (EAR)
    def eye_aspect_ratio(eye):
        A = distance.euclidean(eye[1], eye[5])
        B = distance.euclidean(eye[2], eye[4])
        C = distance.euclidean(eye[0], eye[3])
        return (A + B) / (2.0 * C)

    # Initialize Webcam
    cap = cv2.VideoCapture(0)
    eye_closed_frames = 0
    
    print("[INFO] Starting Webcam Stress Detection...")

    while True:
        ret, frame = cap.read()
        if not ret:
            print("[ERROR] Failed to grab frame.")
            time.sleep(1)
            continue

        rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        result = face_mesh.process(rgb)

        status_flag = "NORMAL 🙂"
        ear = 0.0

        if result.multi_face_landmarks:
            for face_landmarks in result.multi_face_landmarks:
                h, w, _ = frame.shape
                left_eye = []
                right_eye = []

                for idx in LEFT_EYE:
                    lm = face_landmarks.landmark[idx]
                    left_eye.append((int(lm.x * w), int(lm.y * h)))

                for idx in RIGHT_EYE:
                    lm = face_landmarks.landmark[idx]
                    right_eye.append((int(lm.x * w), int(lm.y * h)))

                left_ear = eye_aspect_ratio(left_eye)
                right_ear = eye_aspect_ratio(right_eye)
                ear = (left_ear + right_ear) / 2

                # Thresholds
                if ear < 0.25:
                    eye_closed_frames += 1
                else:
                    eye_closed_frames = 0

                if eye_closed_frames > 15:
                    status_flag = "DROWSY / TIRED 😴"
                elif ear < 0.27: # Slightly adjusted for real-world testing
                    status_flag = "STRESS / ANXIETY ⚠️"
                else:
                    status_flag = "NORMAL 🙂"

                # Draw UI on Webcam Stream
                color = (0, 255, 0) # Green for normal
                if "STRESS" in status_flag: color = (0, 165, 255) # Orange
                if "DROWSY" in status_flag: color = (0, 0, 255) # Red
                
                cv2.putText(frame, f"Status: {status_flag}", (30, 50),
                            cv2.FONT_HERSHEY_DUPLEX, 0.8, color, 2)
                cv2.putText(frame, f"EAR Focus: {ear:.2f}", (30, 90),
                            cv2.FONT_HERSHEY_DUPLEX, 0.6, (200, 200, 200), 1)

        # Update Global State for Flask
        current_status = status_flag
        current_ear = ear

        # Show the window (for debugging/presentation)
        cv2.imshow("Aura Helper - Real-time Diagnostics", frame)

        if cv2.waitKey(1) & 0xFF == 27: # Press 'ESC' to break
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    # Start the OpenCV loop in a background thread so Flask can run
    vision_thread = threading.Thread(target=stress_detection_loop, daemon=True)
    vision_thread.start()
    
    # Run the Flask API Server natively
    app.run(host='0.0.0.0', port=5005, debug=False, use_reloader=False)

import urllib.request
import json
import ssl

url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyCqWoMA0-oXeqwQ24xMFQpK73S-535xtfI"
data = {
    "systemInstruction": { "parts": [{"text":"You are Aura."}] },
    "contents": [{"role":"user","parts":[{"text":"hi tired"}]}]
}
data_snake = {
    "system_instruction": { "parts": [{"text":"You are Aura."}] },
    "contents": [{"role":"user","parts":[{"text":"hi tired"}]}]
}

def check(d, name):
    print(f"Testing {name}...")
    req = urllib.request.Request(url, data=json.dumps(d).encode('utf-8'), headers={'Content-Type': 'application/json'})
    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    try:
        with urllib.request.urlopen(req, context=ctx) as response:
            print("SUCCESS")
    except urllib.error.HTTPError as e:
        print(f"HTTP Error {e.code}: {e.read().decode('utf-8')}")

check(data, "camelCase systemInstruction")
check(data_snake, "snake_case system_instruction")

import 'package:flutter/material.dart';
import 'package:aura_app/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SosModal {
  static void show(BuildContext context, VoidCallback onBreathe, VoidCallback onTalk) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'SOS Modal',
      barrierColor: const Color(0xFF1A1C20).withOpacity(0.95),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "You're not alone.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "What do you need right now?",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildButton(
                    'I need to breathe',
                    PhosphorIcons.wind(),
                    AppTheme.sageGreen,
                    () {
                      Navigator.pop(context);
                      onBreathe();
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    'I need to talk to someone',
                    PhosphorIcons.phoneCall(),
                    AppTheme.danger,
                    () {
                      Navigator.pop(context);
                      onTalk();
                    },
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildButton(String text, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

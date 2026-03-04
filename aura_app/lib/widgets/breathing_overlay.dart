import 'package:flutter/material.dart';
import 'package:aura_app/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BreathingOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const BreathingOverlay({super.key, required this.onClose});

  @override
  State<BreathingOverlay> createState() => _BreathingOverlayState();
}

class _BreathingOverlayState extends State<BreathingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String _breatheText = "Inhale...";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 4s in, 6s out logic roughly
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _breatheText = "Exhale...");
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() => _breatheText = "Inhale...");
          _controller.forward();
        }
      });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.cream,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.sageGreen, width: 2),
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.sageGreenLight,
                        AppTheme.sageGreenLight.withOpacity(0.0),
                      ],
                      stops: const [0.0, 0.7],
                    ),
                  ),
                ),
              );
            },
          ),
          Text(
            _breatheText,
            style: const TextStyle(
              fontSize: 24,
              color: AppTheme.sageGreen,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
          Positioned(
            bottom: 50,
            child: TextButton.icon(
              onPressed: widget.onClose,
              icon: Icon(PhosphorIcons.x(), color: AppTheme.textMuted),
              label: Text(
                'Close',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

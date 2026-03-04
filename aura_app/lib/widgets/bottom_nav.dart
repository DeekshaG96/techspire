import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aura_app/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GlassBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cream.withOpacity(0.85),
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.03)),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, 'Home', PhosphorIcons.house()),
                  _buildNavItem(1, 'Journal', PhosphorIcons.bookOpen()),
                  _buildNavItem(2, 'Stats', PhosphorIcons.chartLineUp()),
                  _buildNavItem(3, 'Settings', PhosphorIcons.gear()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final isActive = index == currentIndex;
    final color = isActive ? AppTheme.sageGreen : AppTheme.textMuted;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

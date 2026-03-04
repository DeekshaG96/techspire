import 'package:flutter/material.dart';
import 'package:aura_app/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:aura_app/screens/web_module_screen.dart';
import 'package:aura_app/widgets/bottom_nav.dart';
import 'package:aura_app/widgets/sos_modal.dart';
import 'package:aura_app/widgets/breathing_overlay.dart';
import 'package:aura_app/widgets/chat_modal.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  bool _isChillMode = false;
  bool _isBreathing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isChillMode ? AppTheme.sageGreenLight : AppTheme.cream,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 30),
                      _buildSectionHeader('Explore Modules'),
                      _buildCardGrid(),
                      const SizedBox(height: 100), // Space for bottom nav
                    ],
                  ),
                ),
              ],
            ),
            if (_isBreathing)
              BreathingOverlay(
                onClose: () => setState(() => _isBreathing = false),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChatModal.show(context);
        },
        backgroundColor: Colors.white,
        child: Icon(PhosphorIcons.chatTeardropDots(PhosphorIconsStyle.fill), color: AppTheme.sageGreen),
      ),
      bottomNavigationBar: GlassBottomNav(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Deeksha',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to find your balance?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isChillMode = !_isChillMode),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isChillMode ? AppTheme.sageGreenLight : Colors.white,
                    border: Border.all(
                      color: _isChillMode ? AppTheme.sageGreen : Colors.black.withOpacity(0.05),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.leaf(),
                        size: 16,
                        color: _isChillMode ? AppTheme.sageGreen : AppTheme.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Chill',
                        style: TextStyle(
                          fontSize: 13,
                          color: _isChillMode ? AppTheme.sageGreen : AppTheme.textMuted,
                          fontWeight: _isChillMode ? FontWeight.bold : FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  SosModal.show(context, () {
                    setState(() => _isBreathing = true);
                  }, () {
                    // Navigate to hotlines
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.dangerSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(PhosphorIcons.warningCircle(PhosphorIconsStyle.fill), size: 16, color: AppTheme.danger),
                      const SizedBox(width: 6),
                      const Text(
                        'Overwhelmed',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.pastelLavenderLight, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Check-in',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'How are you feeling today?',
                  style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.pastelLavender,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Start'),
                )
              ],
            ),
          ),
          Icon(PhosphorIcons.heart(PhosphorIconsStyle.fill), size: 60, color: AppTheme.pastelLavender),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('See all', style: TextStyle(fontSize: 13, color: AppTheme.textMuted, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _buildModuleCard(
          title: 'Deep Vision',
          subtitle: 'Facial stress scan',
          icon: PhosphorIcons.camera(PhosphorIconsStyle.fill),
          color: AppTheme.sageGreen,
          lightColor: AppTheme.sageGreenLight,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WebModuleScreen(
                title: 'Deep Vision',
                assetPath: 'assets/www/webcam-stress.html',
                themeColor: Color(0xFF020205),
              ),
            ));
          },
        ),
        _buildModuleCard(
          title: 'Swipe Calm',
          subtitle: 'Release tension',
          icon: PhosphorIcons.handSwipeRight(PhosphorIconsStyle.fill),
          color: AppTheme.pastelLavender,
          lightColor: AppTheme.pastelLavenderLight,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WebModuleScreen(
                title: 'Swipe Calm',
                assetPath: 'assets/www/swipe-calm.html',
                themeColor: Color(0xFFa8edea),
              ),
            ));
          },
        ),
        _buildModuleCard(
          title: 'Bubble Pop',
          subtitle: 'Mindful popping',
          icon: PhosphorIcons.circlesThree(PhosphorIconsStyle.fill),
          color: Colors.blueAccent,
          lightColor: Colors.blue.shade50,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WebModuleScreen(
                title: 'Bubble Pop',
                assetPath: 'assets/www/bubble-pop.html',
                themeColor: Color(0xFFE8F0EA),
              ),
            ));
          },
        ),
      ],
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color lightColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: lightColor, borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

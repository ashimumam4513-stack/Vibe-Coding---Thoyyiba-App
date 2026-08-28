import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/app_footer.dart';
import '../../../core/state/auth_state.dart';
import '../home/main_layout.dart';
import 'settings_screen.dart';

class AccountScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const AccountScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([AuthState.userName, AuthState.userEmail]),
      builder: (context, _) {
      final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final brandColor = const Color(0xFFCE9B2F);

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          CustomAppBar(
            onThemeToggle: onThemeToggle,
            isDarkMode: isDarkMode,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'ACCOUNT',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: brandColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'HELLO, ${AuthState.userName.value.isNotEmpty ? AuthState.userName.value.toUpperCase() : 'UMAM'}.',
                        style: const TextStyle(fontFamily: 'Nura').copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(color: dividerColor),
                    ),
                    const SizedBox(height: 32),

                    // User Info
                    _buildInfoSection('TIER', 'Explorer · 01', mutedColor, textColor, true),
                    const SizedBox(height: 24),
                    _buildInfoSection('POINTS', '0', mutedColor, textColor, false),
                    const SizedBox(height: 24),
                    _buildInfoSection('EMAIL', AuthState.userEmail.value.isNotEmpty ? AuthState.userEmail.value : 'ashimua009@gmail.com', mutedColor, textColor, false),

                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(color: dividerColor),
                    ),
                    const SizedBox(height: 32),

                    // Action Boxes
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          _buildActionBox(
                            'ORDERS', 'Pesanan saya',
                            dividerColor, textColor, mutedColor,
                            onTap: () => MainLayoutScreen.of(context)?.switchTab(6),
                          ),
                          const SizedBox(height: 16),
                          _buildActionBox('MANAGE', 'Account settings', dividerColor, textColor, mutedColor, onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsScreen(
                                    onThemeToggle: onThemeToggle,
                                    isDarkMode: isDarkMode,
                                  ),
                                ),
                              );
                            }),
                          const SizedBox(height: 16),
                          _buildActionBox(
                            'SHOP', 'Browse the collection',
                            dividerColor, textColor, mutedColor,
                            onTap: () => MainLayoutScreen.of(context)?.switchTab(1),
                          ),
                          const SizedBox(height: 16),
                          _buildActionBox(
                            'CIRCLE', 'See tier benefits',
                            dividerColor, textColor, mutedColor,
                            onTap: () => MainLayoutScreen.of(context)?.switchTab(5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 64),

                    // Sign Out
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          AuthState.isLoggedIn.value = false;
                        },
                        child: Text(
                          'SIGN OUT',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: mutedColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 64),
                    const AppFooter(),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
      }
    );
  }

  Widget _buildInfoSection(String label, String value, Color mutedColor, Color textColor, bool isItalic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: mutedColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBox(
    String label,
    String actionText,
    Color dividerColor,
    Color textColor,
    Color mutedColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: mutedColor.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  actionText,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: textColor,
                  ),
                ),
                Icon(Icons.arrow_forward, size: 16, color: textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





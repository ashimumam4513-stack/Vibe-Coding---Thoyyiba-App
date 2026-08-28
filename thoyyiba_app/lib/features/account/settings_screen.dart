import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/state/auth_state.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../core/theme/app_tokens.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const SettingsScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1A17) : const Color(0xFFF9F6F0);
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'SETTINGS',
          style: const TextStyle(fontFamily: 'Nura').copyWith(
            color: textColor,
            letterSpacing: 2.0,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxxl32px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE SECTION
            Text(
              'ACCOUNT',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: mutedColor,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: AppSpacing.xl16px),
            _buildSettingsItem(
              icon: Icons.person_outline,
              label: 'Personal Information',
              onTap: () {},
              textColor: textColor,
              dividerColor: dividerColor,
            ),
            _buildSettingsItem(
              icon: Icons.lock_outline,
              label: 'Password & Security',
              onTap: () {},
              textColor: textColor,
              dividerColor: dividerColor,
            ),
            
            const SizedBox(height: AppSpacing.xxxxxxxl64px),
            
            // PREFERENCES SECTION
            Text(
              'PREFERENCES',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: mutedColor,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: AppSpacing.xl16px),
            _buildSwitchItem(
              icon: Icons.notifications_none_outlined,
              label: 'Push Notifications',
              value: _notificationsEnabled,
              onChanged: (val) {
                setState(() => _notificationsEnabled = val);
              },
              textColor: textColor,
              dividerColor: dividerColor,
            ),
            _buildSwitchItem(
              icon: widget.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              label: 'Dark Mode',
              value: widget.isDarkMode,
              onChanged: (val) {
                widget.onThemeToggle();
              },
              textColor: textColor,
              dividerColor: dividerColor,
            ),

            const SizedBox(height: AppSpacing.xxxxxxxl64px),

            // OTHERS SECTION
            Text(
              'SUPPORT & ABOUT',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: mutedColor,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: AppSpacing.xl16px),
            _buildSettingsItem(
              icon: Icons.help_outline,
              label: 'Help Center',
              onTap: () {},
              textColor: textColor,
              dividerColor: dividerColor,
            ),
            _buildSettingsItem(
              icon: Icons.privacy_tip_outlined,
              label: 'Privacy Policy',
              onTap: () {},
              textColor: textColor,
              dividerColor: dividerColor,
            ),

            const SizedBox(height: AppSpacing.xxxxxxxl64px),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  AuthState.isLoggedIn.value = false;
                  AuthState.userName.value = '';
                  AuthState.userEmail.value = '';
                  Navigator.pop(context); // Go back to Account or Home
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: Text(
                  'SIGN OUT',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxxxxxxxxl128px),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color textColor,
    required Color dividerColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl16px),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor)),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 24),
            const SizedBox(width: AppSpacing.xl16px),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: textColor.withValues(alpha: 0.5), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color textColor,
    required Color dividerColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm6px), // Switch provides its own padding natively
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: dividerColor)),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 24),
          const SizedBox(width: AppSpacing.xl16px),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFCE9B2F),
          ),
        ],
      ),
    );
  }
}


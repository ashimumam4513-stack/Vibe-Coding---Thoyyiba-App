import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_glow_button.dart';

enum ButtonType { primary, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == ButtonType.primary;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Fetch colors from theme or fallback
    final primaryBgColor = theme.colorScheme.primary; 
    final primaryTextColor = theme.colorScheme.onPrimary;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: isPrimary
          ? AnimatedGlowButton(
              text: text,
              onPressed: onPressed,
              backgroundColor: primaryBgColor,
              textColor: primaryTextColor,
              isDarkMode: isDark,
              child: icon != null ? _buildContent() : null,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.textTheme.bodyLarge?.color,
                side: BorderSide(
                  color: theme.dividerColor.withOpacity(0.2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _buildContent(),
            ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 12),
        ],
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: type == ButtonType.outline ? 1.2 : 0,
          ),
        ),
      ],
    );
  }
}

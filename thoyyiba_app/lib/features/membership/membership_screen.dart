import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/floating_bottom_nav.dart';
import '../../shared/widgets/app_footer.dart';
import 'membership_payment_screen.dart';

class MembershipScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MembershipScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final borderColor = isDark ? Colors.white12 : Colors.black12;

    return Scaffold(
      extendBody: true,
      body: Column(
          children: [
            CustomAppBar(
              onThemeToggle: widget.onThemeToggle,
              isDarkMode: widget.isDarkMode,
            ),
            Expanded(
              child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                'THE CIRCLE',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: const Color(0xFFCE9B2F),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'MEMBERSHIP, EARNED.',
                  style: const TextStyle(fontFamily: 'Nura').copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'A quiet system of tiers built to reward the ritual of return. Legend is never for sale — only earned.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.5,
                    color: mutedColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: borderColor)),
                  child: Column(
                    children: [
                      _buildTierSection(
                        number: '01',
                        points: '0 pts',
                        title: 'Explorer',
                        subtitle: 'FREE TO JOIN',
                        benefits: [
                          'Early access to seasonal harvest notes',
                          'Community recipe guides',
                          'Order tracking and personal library',
                        ],
                        isDark: isDark,
                      ),
                      Divider(color: borderColor, height: 1),
                      _buildTierSection(
                        number: '02',
                        points: '1,200 pts',
                        pointsColor: const Color(0xFFCE9B2F),
                        title: 'Pro',
                        subtitle: 'EARNED OR FAST-TRACK',
                        benefits: [
                          '10% off every order',
                          'Priority shipping on Limited Drops',
                          'Quarterly curated sampler from remote apiaries',
                        ],
                        isDark: isDark,
                      ),
                      Divider(color: borderColor, height: 1),
                      _buildTierSection(
                        number: '03',
                        points: '5,000 pts',
                        title: 'Legend',
                        subtitle: 'EARNED ONLY',
                        benefits: [
                          'Concierge wellness consultation',
                          'Allocation of rarest single-hive reserves',
                          'Invitations to private harvest events',
                        ],
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: CustomButton(
                  text: 'Join The Club',
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MembershipPaymentScreen(
                            
                            onThemeToggle: widget.onThemeToggle,
                            isDarkMode: widget.isDarkMode,
                          ),
                        ),
                      );
                    },
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'EXPLORER IS COMPLIMENTARY · PRO FAST-TRACK AVAILABLE ON ACCOUNT',
                  style: GoogleFonts.montserrat(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: mutedColor.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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

  Widget _buildTierSection({
    required String number,
    required String points,
    required String title,
    required String subtitle,
    required List<String> benefits,
    required bool isDark,
    Color? pointsColor,
  }) {
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$number · ',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: mutedColor.withOpacity(0.5),
                ),
              ),
              Text(
                points,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: pointsColor ?? mutedColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontFamily: 'Nura').copyWith(
              fontSize: 24,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.montserrat(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: mutedColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '—',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFFCE9B2F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        benefit,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: mutedColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}












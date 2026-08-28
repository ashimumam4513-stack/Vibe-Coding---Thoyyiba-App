import 'package:flutter/material.dart';
import 'dart:math';

import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/floating_bottom_nav.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/app_footer.dart';
import 'main_layout.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/product_card.dart';
import '../auth/sign_up_screen.dart';
import '../../core/state/auth_state.dart';
import '../../core/state/auth_state.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;

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
          padding: const EdgeInsets.only(bottom: AppSpacing.xxxxxxxxxxl128px), // For bottom nav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(theme, textColor, mutedColor),
              _buildApothecarySection(theme, textColor, mutedColor),
              _buildCountdownBanner(theme, isDark),
              _buildTheCircleSection(theme, textColor, mutedColor),
              const SizedBox(height: AppSpacing.xxxxxxxl64px),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
  
    );
  }

  Widget _buildHeroSection(ThemeData theme, Color textColor, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxl24px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "L'OR DE JAVA",
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFFC9A24B),
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "THE GOLDEN STANDARD OF INDONESIAN FLORA.",
            style: theme.textTheme.displayMedium?.copyWith(
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.xl16px),
          Text(
            "Sourced from the heart of Java's pristine forests, our products are crafted with nature's pure essence, delivering the golden standard of wellness to your daily rituals.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: mutedColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl24px),
          SizedBox(
            width: 200,
            child: CustomButton(
              text: 'Discover The Legend',
              onPressed: () {
                final mainLayout = MainLayoutScreen.of(context);
                if (mainLayout != null) {
                  mainLayout.switchTab(1);
                }
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xxxxl32px),
          // Hero Image Placeholder (Ripped edges implied)
            CustomPaint(
              foregroundPainter: TornPaperPainter(color: const Color(0xFFC9A24B).withOpacity(0.5), strokeWidth: 1.0),
              child: ClipPath(
                clipper: TornPaperClipper(),
                child: Image.asset('assets/images/hero_honey.png', width: double.infinity, height: 400, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      );
    }
  
    Widget _buildApothecarySection(ThemeData theme, Color textColor, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxxl32px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "The Apothecary",
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                "Discover all products",
                style: theme.textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.underline,
                  color: mutedColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl24px),
          // Dummy Products list
          SizedBox(height: 350, child: ProductCard(
            title: "Wild Trigona",
            price: "Rp 450.000",
            imageUrl: "assets/images/wild_trigona.png", // Updated image
            
          )),
          const SizedBox(height: AppSpacing.xl16px),
          SizedBox(height: 350, child: ProductCard(
            title: "Sumbawa Forest Gold",
            price: "Rp 250.000",
            imageUrl: "assets/images/sumbawa_forest_gold.png", 
            
          )),
          const SizedBox(height: AppSpacing.xl16px),
          SizedBox(height: 350, child: ProductCard(
            title: "Raw Java Blossom Honey",
              price: "Rp 310.000",
              imageUrl: "assets/images/java_blossom.png",
            
          )),
        ],
      ),
    );
  }

  Widget _buildCountdownBanner(ThemeData theme, bool isDark) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxl24px),
        child: CustomPaint(
          foregroundPainter: TornPaperPainter(color: const Color(0xFFC9A24B), strokeWidth: 2.0),
          child: ClipPath(
            clipper: TornPaperClipper(),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xxxl24px),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF161413) : const Color(0xFF26201B),
              ),
              child: Column(
                children: [
                  Text(
                    "LE RITUEL DE JAVA",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFC9A24B),
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl16px),
                  Text(
                    "THE LEGEND EDIT DROPS IN",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxxl24px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTimeUnit("02", "Days", theme),
                      _buildColon(),
                      _buildTimeUnit("14", "Hours", theme, isHighlight: true),
                      _buildColon(),
                      _buildTimeUnit("36", "Mins", theme),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxxl24px),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFC9A24B)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xs4px)),
                    ),
                    child: Text(
                      "Notify Me",
                      style: theme.textTheme.labelLarge?.copyWith(color: const Color(0xFFC9A24B)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  
      Widget _buildTimeUnit(String value, String label, ThemeData theme, {bool isHighlight = false}) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.displaySmall?.copyWith(
            color: isHighlight ? const Color(0xFFC9A24B) : Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildColon() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        ":",
        style: TextStyle(fontSize: 24, color: Colors.white54, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildTheCircleSection(ThemeData theme, Color textColor, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxxl32px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "The Circle",
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xxxl24px),
          _buildTierInfo("Explorer", "Start your journey and get access to our exclusive newsletter and product launches.", theme, textColor),
          _buildTierInfo("Apprentice", "Enjoy 10% off on all purchases and early access to limited edition drops.", theme, textColor, isHighlight: true),
          _buildTierInfo("Legend", "Complimentary shipping, a curated birthday gift, and exclusive event invites.", theme, textColor),
          const SizedBox(height: AppSpacing.xxxxl32px),
          ValueListenableBuilder<bool>(
              valueListenable: AuthState.isLoggedIn,
              builder: (context, isLoggedIn, child) {
                if (isLoggedIn) return const SizedBox.shrink();
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Sign In or Sign Up',
              type: ButtonType.outline,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                        onThemeToggle: widget.onThemeToggle,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                  );
                },
              ),
            );
            }),
          ],
      ),
    );
  }

  Widget _buildTierInfo(String title, String desc, ThemeData theme, Color textColor, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.stop, size: 12, color: isHighlight ? const Color(0xFFC9A24B) : textColor.withOpacity(0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: textColor.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalSection(ThemeData theme, Color textColor, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discover The Origins",
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFFC9A24B),
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: AppSpacing.xl16px),
          _buildArticleCard("THE MAKING OF THE LEGEND: A JOURNEY TO...", "Read more", theme, mutedColor),
          const SizedBox(height: AppSpacing.xl16px),
          _buildArticleCard("A RITUAL OF HEALING: THE BENEFITS OF...", "Read more", theme, mutedColor),
        ],
      ),
    );
  }

  Widget _buildArticleCard(String title, String action, ThemeData theme, Color mutedColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: theme.dividerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(Icons.article_outlined, color: mutedColor.withOpacity(0.5), size: 48),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          action,
          style: theme.textTheme.bodySmall?.copyWith(
            decoration: TextDecoration.underline,
            color: mutedColor,
          ),
        ),
      ],
    );
  }
}




class TornPaperPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  TornPaperPainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Path path = TornPaperClipper().getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TornPaperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final rng = Random(42);
    double step = 10.0;
    double variance = 8.0;

    // Top torn edge
    path.moveTo(0, variance);
    for (double x = 0; x <= size.width + step; x += step) {
      path.lineTo(x - step / 2, rng.nextDouble() * variance);
      path.lineTo(x, variance + rng.nextDouble() * variance);
    }

    path.lineTo(size.width, size.height - variance * 2);

    // Bottom torn edge
    for (double x = size.width; x >= -step; x -= step) {
      path.lineTo(x + step / 2, size.height - rng.nextDouble() * variance);
      path.lineTo(x, size.height - variance - rng.nextDouble() * variance);
    }

    path.lineTo(0, variance);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


























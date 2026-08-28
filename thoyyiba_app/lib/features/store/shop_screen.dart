import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/floating_bottom_nav.dart';
import '../../core/state/cart_state.dart';
import '../../core/state/cart_state.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/app_footer.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/product_card.dart';

class ShopScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ShopScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

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
              onThemeToggle: onThemeToggle,
              isDarkMode: isDarkMode,
            ),
            Expanded(
              child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxxxxxxxxxl128px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(theme, textColor, mutedColor),
              _buildCategorySection(
                theme,
                title: "Honey",
                items: [
                  _buildShopItem("Wild Trigona", "Rp 450.000", context, imageUrl: "assets/images/wild_trigona.png"),
                    _buildShopItem("Wild Cajuput Honey", "Rp 120.000", context, imageUrl: "assets/images/wild_cajuput_honey.png"),
                  _buildShopItem("Sumbawa Forest Gold", "Rp 250.000", context, imageUrl: "assets/images/sumbawa_forest_gold.png"),
                ],
              ),
              _buildCategorySection(
                theme,
                title: "Herbal",
                items: [
                  _buildShopItem("Raw Java Blossom Honey", "Rp 310.000", context, imageUrl: "assets/images/java_blossom.png"),
                  _buildShopItem("Golden Etawa Milk", "Rp 185.000", context, imageUrl: "assets/images/golden_etawa_milk.png"),
                    _buildShopItem("Forest Propolis Drops", "Rp 245.000", context, imageUrl: "assets/images/forest_propolis_drops.png"),
                ],
              ),
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

  Widget _buildHeaderSection(ThemeData theme, Color textColor, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxxl32px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "L'OR DE JAVA",
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFFC9A24B),
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: AppSpacing.xl16px),
          Text(
            "EVERY JAR, A SEASON CAPTURED.",
            style: theme.textTheme.displayMedium?.copyWith(
              fontSize: 36,
              color: textColor,
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl24px),
          Text(
            "Sourced from deep within the wild forests of Java. Where every drop is a promise of pure, unadulterated healing.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: mutedColor,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.xxxxl32px),
          Divider(color: theme.dividerColor.withValues(alpha: 0.1)),
        ],
      ),
    );
  }

  Widget _buildCategorySection(ThemeData theme, {required String title, required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxl24px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl24px),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xxxxl32px),
                child: item,
              )),
          const SizedBox(height: AppSpacing.xl16px),
          Divider(color: theme.dividerColor.withValues(alpha: 0.1)),
        ],
      ),
    );
  }

  Widget _buildShopItem(String title, String price, BuildContext context, {String imageUrl = ""}) {
    return SizedBox(
      height: 350,
      child: ProductCard(
        title: title,
        price: price,
        imageUrl: imageUrl,
        onAddToCart: () {
          CartState.addItem(CartItem(
            id: title,
            title: title,
            price: price,
            imageUrl: imageUrl,
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title added to bag")),
          );
        },
      ),
    );
  }
}























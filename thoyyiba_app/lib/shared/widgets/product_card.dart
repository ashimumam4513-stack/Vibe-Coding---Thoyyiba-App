import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_tokens.dart';
import 'package:share_plus/share_plus.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback? onAddToCart;
  final bool showShareIcon;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.onAddToCart,
    this.showShareIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container with Floating Add to Bag Button
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                child: imageUrl.isNotEmpty
                    ? Image.asset(imageUrl, fit: BoxFit.cover)
                    : const Center(
                        child: Icon(Icons.image_outlined, color: Colors.grey, size: 48),
                      ),
              ),
              if (onAddToCart != null)
              Positioned(
                top: AppSpacing.md8px,
                right: AppSpacing.md8px,
                child: Row(
                  children: [
                    if (showShareIcon)
                    GestureDetector(
                      onTap: () {
                        // Share logic here
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md8px),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.xs4px),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.share_outlined,
                          size: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                    if (showShareIcon) const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md8px),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.xs4px),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg12px),
        // Product Details
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 14,
            color: textColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs4px),
        Text(
          price,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: mutedColor.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}








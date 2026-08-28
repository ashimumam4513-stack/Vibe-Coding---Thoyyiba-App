import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/floating_bottom_nav.dart';
import '../../../shared/widgets/app_footer.dart';
import '../../../shared/widgets/animated_glow_button.dart';
import '../../../core/state/cart_state.dart';
import 'checkout_screen.dart';
import '../home/main_layout.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const CartScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final brandColor = const Color(0xFFCE9B2F); // Gold color from token
    final bgColor = isDark ? const Color(0xFF38312B) : const Color(0xFFF9F6F0);

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: ValueListenableBuilder<List<CartItem>>(
          valueListenable: CartState.items,
          builder: (context, items, child) {
            final bool _isCartEmpty = items.isEmpty;
            return Column(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'YOUR BAG',
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
                          _isCartEmpty ? 'NOTHING HERE YET.' : 'READY WHEN YOU ARE.',
                          style: const TextStyle(
                            fontFamily: 'Nura',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ).copyWith(
                            color: textColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Content based on state
                      if (_isCartEmpty)
                        _buildEmptyState(context, isDark)
                      else
                        _buildFilledState(textColor, mutedColor, dividerColor, brandColor, isDark),

                      const SizedBox(height: 64),
                      const AppFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        text: 'Browse The Collection',
        onPressed: () {
          MainLayoutScreen.of(context)?.switchTab(1);
        },
      ),
    );
  }

  Widget _buildFilledState(Color textColor, Color mutedColor, Color dividerColor, Color brandColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...CartState.items.value.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.imageUrl.isNotEmpty ? ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.asset(item.imageUrl, width: 80, height: 80, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(width: 80, height: 80, color: isDark ? Colors.white10 : Colors.black12, child: const Icon(Icons.image_outlined, color: Colors.grey)))) : Container(width: 80, height: 80, color: isDark ? Colors.white10 : Colors.black12, child: const Icon(Icons.image_outlined, color: Colors.grey)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: textColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.price,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: dividerColor),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () { CartState.updateQuantity(item.id, -1); },
                                    child: Text('-', style: TextStyle(color: textColor, fontSize: 16)),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(item.quantity.toString(), style: TextStyle(color: textColor, fontSize: 14)),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () { CartState.updateQuantity(item.id, 1); },
                                    child: Text('+', style: TextStyle(color: textColor, fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () { CartState.removeItem(item.id); },
                              child: Text(
                                'REMOVE',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  color: mutedColor.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Divider(color: dividerColor),
          const SizedBox(height: 24),
          
          GestureDetector(
            onTap: () { CartState.clearCart(); },
            child: Text(
              'CLEAR BAG',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: mutedColor.withValues(alpha: 0.5),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          Divider(color: dividerColor),
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SUBTOTAL',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: mutedColor.withValues(alpha: 0.5),
                ),
              ),
              Text(
                CartState.formattedSubtotal,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'SHIPPING CALCULATED AT CHECKOUT',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: mutedColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 48),

          // Custom Checkout Button (Double Border Style)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(
                    onThemeToggle: widget.onThemeToggle,
                    isDarkMode: widget.isDarkMode,
                  ),
                ),
              );
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: brandColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: brandColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Center(
                    child: Text(
                      'CHECKOUT',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
















import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/app_footer.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/state/order_state.dart';
import '../home/main_layout.dart';

class OrdersScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const OrdersScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DummyOrder>>(
      valueListenable: OrderState.orders,
      builder: (context, ordersList, child) {
        final hasOrders = ordersList.isNotEmpty;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1E1A17) : const Color(0xFFF9F6F0);
        final textColor = isDark ? Colors.white : Colors.black;
        final mutedColor = isDark ? Colors.white70 : Colors.black54;
        final brandColor = const Color(0xFFCE9B2F);
        final dividerColor = isDark ? Colors.white24 : Colors.black12;

        return Scaffold(
          backgroundColor: bgColor,
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
                      children: [
                        const SizedBox(height: AppSpacing.xxxxxl40px),
                        Text(
                          'MY ORDERS',
                          style: const TextStyle(fontFamily: 'Nura').copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: brandColor,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxxl32px),

                        // Body
                        hasOrders
                            ? _buildFilledState(context, textColor, mutedColor, dividerColor, brandColor, isDark, ordersList)
                            : _buildEmptyState(context, textColor, mutedColor, dividerColor, brandColor),

                        const SizedBox(height: AppSpacing.xxxxxxxl64px),

                        // Back to Account link
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
                          child: GestureDetector(
                            onTap: () {
                              final layout = MainLayoutScreen.of(context);
                              if (layout != null) {
                                layout.switchTab(4); // Switch to Account Tab
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back, color: mutedColor, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'Back to Account',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: mutedColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxxxxxl64px),
                        AppFooter(),
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

  // ?? FILLED STATE ?????????????????????????????????????????????????????????????

  Widget _buildFilledState(BuildContext context, Color textColor, Color mutedColor, Color dividerColor, Color brandColor, bool isDark, List<DummyOrder> ordersToDisplay) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
      child: Column(
        children: ordersToDisplay.map((order) => _buildOrderCard(context, order, textColor, mutedColor, dividerColor, brandColor, isDark)).toList(),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    DummyOrder order,
    Color textColor,
    Color mutedColor,
    Color dividerColor,
    Color brandColor,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order ID
        Text(
          order.orderId,
          style: const TextStyle(fontFamily: 'Nura').copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Date & Location
        Text(
          '${order.date} • ${order.location}',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: mutedColor,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),

        // Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STATUS',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: mutedColor,
                letterSpacing: 1.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: brandColor.withValues(alpha: 0.1),
                border: Border.all(color: brandColor.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                order.statusLabel,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: brandColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Product Item
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              color: isDark ? Colors.white10 : Colors.black12,
              child: order.imageUrl.isNotEmpty 
                  ? Image.asset(order.imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.image_outlined, color: Colors.grey),
            ),
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
                          order.productName,
                          style: const TextStyle(fontFamily: 'Nura').copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      Text(
                        'Rp ${order.productPrice}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'QTY: ${order.qty}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Divider(color: dividerColor, height: 1, thickness: 1),
        const SizedBox(height: 24),

        // Cost Breakdown
        _buildSummaryRow('SUBTOTAL', order.subtotal, mutedColor, textColor),
        const SizedBox(height: 12),
        _buildSummaryRow('SHIPPING (${order.shippingType.toUpperCase()})', order.shippingPrice, mutedColor, textColor),
        const SizedBox(height: 16),
        _buildSummaryRow('TOTAL', order.total, textColor, textColor, isTotal: true),
        const SizedBox(height: 24),
        if (order.statusLabel == 'MENUNGGU PEMBAYARAN')
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                OrderState.removeOrder(order.orderId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment cancelled')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'CANCEL PAYMENT',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildSummaryRow(String label, int amount, Color labelColor, Color valueColor, {bool isTotal = false}) {
    final formatter = amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: labelColor,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          'Rp $formatter',
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // ?? EMPTY STATE ??????????????????????????????????????????????????????????????

  Widget _buildEmptyState(BuildContext context, Color textColor, Color mutedColor, Color dividerColor, Color brandColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxxxl40px),
            decoration: BoxDecoration(
              border: Border.all(color: dividerColor),
              borderRadius: BorderRadius.circular(AppRadius.xs4px),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 48,
                  color: mutedColor.withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppSpacing.xl16px),
                Text(
                  'No orders yet',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm6px),
                Text(
                  'Your order history will appear here',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: mutedColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxxl32px),
                CustomButton(
                  text: 'START SHOPPING',
                  onPressed: () {
                    final layout = MainLayoutScreen.of(context);
                    if (layout != null) {
                      layout.switchTab(1); // Shop Tab
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



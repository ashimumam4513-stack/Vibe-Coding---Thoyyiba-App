import 'package:flutter/material.dart';
import '../../core/state/auth_state.dart';
import '../../core/state/order_state.dart';
import '../orders/orders_screen.dart';
import '../home/main_layout.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/state/cart_state.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/floating_bottom_nav.dart';
import '../../../shared/widgets/app_footer.dart';
import '../../../shared/widgets/animated_glow_button.dart';

class CheckoutScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const CheckoutScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _shippingCost = 25000;
  bool _isBankTransferExpanded = true;
  bool _isEWalletExpanded = true;
  String _selectedPayment = 'GoPay';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white24 : Colors.black26;
    final brandColor = const Color(0xFFCE9B2F); // Gold color from token
    final bgColor = isDark ? const Color(0xFF1E1A17) : const Color(0xFFF9F6F0);
    // Note: The figma shows a slightly darker background for checkout in dark mode maybe, but we'll stick to the token or close to it.
    final actualBgColor = isDark ? const Color(0xFF1C1714) : const Color(0xFFF9F6F0); // close to Figma

    return Scaffold(
      backgroundColor: actualBgColor,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Column(
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
                          'CHECKOUT',
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
                          'ALMOST YOURS.',
                          style: const TextStyle(
                            fontFamily: 'Nura',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ).copyWith(
                            color: textColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      if (!AuthState.isLoggedIn.value) ...[
                        // CONTACT SECTION
                        _buildSectionTitle('CONTACT', mutedColor),
                        _buildTextField('Full name', textColor, dividerColor),
                        _buildTextField('Email', textColor, dividerColor),
                        _buildTextField('Phone / WhatsApp', textColor, dividerColor),
                        const SizedBox(height: 48),
                      ],

                      // SHIPPING ADDRESS SECTION
                      _buildSectionTitle('SHIPPING ADDRESS', mutedColor),
                      _buildTextField('Street address', textColor, dividerColor),
                      _buildTextField('City', textColor, dividerColor),
                      _buildTextField('Province', textColor, dividerColor),
                      _buildTextField('Postal code', textColor, dividerColor),
                      _buildTextField('Delivery notes (optional)', textColor, dividerColor),
                      const SizedBox(height: 48),

                      // DELIVERY SECTION
                      _buildSectionTitle('DELIVERY', mutedColor),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            _buildShippingOption(
                              'Regular — 2-4 days',
                              'Rp 25.000',
                              25000,
                              textColor,
                              dividerColor,
                              brandColor,
                            ),
                            const SizedBox(height: 16),
                            _buildShippingOption(
                              'Express — next day',
                              'Rp 60.000',
                              60000,
                              textColor,
                              dividerColor,
                              brandColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // PAYMENT METHOD SECTION
                      _buildSectionTitle('PAYMENT METHOD', mutedColor),
                      _buildDropdownSection(
                        title: 'BANK TRANSFER',
                        isExpanded: _isBankTransferExpanded,
                        onToggle: () => setState(() => _isBankTransferExpanded = !_isBankTransferExpanded),
                        textColor: textColor,
                        mutedColor: mutedColor,
                        children: [
                          _buildPaymentOption('BCA', 'BCA VIRTUAL ACCOUNT', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('Bank Mandiri', 'BANK MANDIRI', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('BNI', 'BANK NEGARA INDONESIA', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('BRI', 'BANK RAKYAT INDONESIA', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('Bank Permata', 'BANK PERMATA', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('CIMB Niaga', 'CIMB NIAGA', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('BSI', 'BANK SYARIAH INDONESIA', textColor, dividerColor, brandColor, mutedColor),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildDropdownSection(
                        title: 'E-WALLET',
                        isExpanded: _isEWalletExpanded,
                        onToggle: () => setState(() => _isEWalletExpanded = !_isEWalletExpanded),
                        textColor: textColor,
                        mutedColor: mutedColor,
                        children: [
                          _buildPaymentOption('GoPay', 'E-WALLET', textColor, dividerColor, brandColor, mutedColor),
                          _buildPaymentOption('OVO', 'E-WALLET', textColor, dividerColor, brandColor, mutedColor),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // PLACE ORDER BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ValueListenableBuilder<List<CartItem>>(
                          valueListenable: CartState.items,
                          builder: (context, items, child) {
                            final total = CartState.subtotal + _shippingCost;
                            final formatter = total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
                            return AnimatedGlowButton(
                              text: 'Place order • Rp $formatter',
                              backgroundColor: brandColor,
                              textColor: Colors.white,
                              isDarkMode: isDark,
                              borderRadius: 4,
                              onPressed: () {
                                  if (!AuthState.isLoggedIn.value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Anda harus Login atau Sign Up untuk melakukan checkout!')),
                                    );
                                    return;
                                  }
                                  for (final item in CartState.items.value) {
                                    OrderState.addOrder(DummyOrder(
                                      orderId: 'THY-NEW' + DateTime.now().millisecondsSinceEpoch.toString().substring(7),
                                      date: 'HARI INI',
                                      location: 'ALAMAT PENGIRIMAN',
                                      statusLabel: 'MENUNGGU PEMBAYARAN',
                                      productName: item.title,
                                      imageUrl: item.imageUrl,
                                      qty: item.quantity,
                                      productPrice: int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                                      shippingPrice: _shippingCost,
                                      shippingType: _shippingCost == 25000 ? 'regular' : 'express',
                                    ));
                                  }
                                  CartState.items.value = []; // Clear cart
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Order placed successfully!')),
                                  );
                                  
                                  final layout = MainLayoutScreen.of(context);
                                  if (layout != null) {
                                    Navigator.pop(context); // close checkout
                                    layout.switchTab(6); // go to orders
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode, initialIndex: 6)),
                                      (route) => false,
                                    );
                                  }
                                },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 48),

                      // ORDER SUMMARY SECTION
                      _buildSectionTitle('ORDER SUMMARY', mutedColor),
                      ValueListenableBuilder<List<CartItem>>(
                        valueListenable: CartState.items,
                        builder: (context, items, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...items.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 64,
                                          color: Colors.black12,
                                          child: item.imageUrl.isNotEmpty ? Image.asset(item.imageUrl, fit: BoxFit.cover) : const Icon(Icons.image_outlined, color: Colors.grey),
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
                                                      item.title,
                                                      style: GoogleFonts.playfairDisplay(
                                                        fontSize: 16,
                                                        fontStyle: FontStyle.italic,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    item.price,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: textColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'QTY ${item.quantity}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 10,
                                                  letterSpacing: 1.0,
                                                  color: mutedColor.withValues(alpha: 0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                Divider(color: dividerColor),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: GoogleFonts.inter(fontSize: 12, color: textColor),
                                    ),
                                    Text(
                                      CartState.formattedSubtotal,
                                      style: GoogleFonts.inter(fontSize: 12, color: textColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping',
                                      style: GoogleFonts.inter(fontSize: 12, color: textColor),
                                    ),
                                    Text(
                                      'Rp ${_shippingCost.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                      style: GoogleFonts.inter(fontSize: 12, color: textColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Divider(color: dividerColor),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.inter(fontSize: 14, color: textColor),
                                    ),
                                    Text(
                                      'Rp ${(CartState.subtotal + _shippingCost).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                      style: GoogleFonts.inter(fontSize: 16, color: textColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 48),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'BACK TO BAG',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      color: mutedColor.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 64),
                      const AppFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: color.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, Color textColor, Color dividerColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: TextField(
        style: GoogleFonts.inter(fontSize: 14, color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            color: textColor.withValues(alpha: 0.4),
          ),
          contentPadding: const EdgeInsets.only(bottom: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: dividerColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildShippingOption(String title, String price, int cost, Color textColor, Color dividerColor, Color brandColor) {
    final isSelected = _shippingCost == cost;
    return GestureDetector(
      onTap: () {
        setState(() {
          _shippingCost = cost;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? brandColor : dividerColor),
          color: isSelected ? brandColor.withValues(alpha: 0.05) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? brandColor : dividerColor, width: 2),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: brandColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(fontSize: 12, color: textColor),
              ),
            ),
            Text(
              price,
              style: GoogleFonts.inter(fontSize: 12, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDropdownSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<Widget> children,
    required Color textColor,
    required Color mutedColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    color: mutedColor,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: mutedColor,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: mutedColor.withValues(alpha: 0.2)),
                  left: BorderSide(color: mutedColor.withValues(alpha: 0.2)),
                  right: BorderSide(color: mutedColor.withValues(alpha: 0.2)),
                ),
              ),
              child: Column(
                children: children,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, Color textColor, Color dividerColor, Color brandColor, Color mutedColor) {
    final isSelected = _selectedPayment == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor)),
          color: isSelected ? brandColor.withValues(alpha: 0.05) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? brandColor : dividerColor,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Text(title, style: GoogleFonts.inter(fontSize: 12, color: textColor)),
              ],
            ),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 8, color: mutedColor, letterSpacing: 1.0)),
          ],
        ),
      ),
    );
  }
}







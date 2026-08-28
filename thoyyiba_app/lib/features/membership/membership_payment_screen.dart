import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/custom_button.dart';
import '../home/main_layout.dart';
import '../../core/state/auth_state.dart';

class MembershipPaymentScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MembershipPaymentScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<MembershipPaymentScreen> createState() => _MembershipPaymentScreenState();
}

class _MembershipPaymentScreenState extends State<MembershipPaymentScreen> {
  String _selectedPackage = 'Explorer';
  String _selectedPayment = 'BCA';
  bool _isPackageExpanded = true;
  bool _isBankTransferExpanded = true;
  bool _isEWalletExpanded = false;

  final Map<String, int> _packages = {
    'Explorer': 0,
    'Pro': 250000,
    'Legend': 1500000,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1A17) : const Color(0xFFF9F6F0);
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white70 : Colors.black87;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final brandColor = const Color(0xFFCE9B2F);

    final total = _packages[_selectedPackage] ?? 0;
    final formatter = total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'MEMBERSHIP',
          style: const TextStyle(fontFamily: 'Nura').copyWith(
            color: textColor,
            letterSpacing: 2.0,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxxxl32px),

            // PACKAGE SECTION
            _buildSectionTitle('MEMBERSHIP TIER', mutedColor),
            _buildDropdownSection(
              title: 'SELECT PACKAGE',
              isExpanded: _isPackageExpanded,
              onToggle: () => setState(() => _isPackageExpanded = !_isPackageExpanded),
              textColor: textColor,
              mutedColor: mutedColor,
              children: [
                _buildPackageOption('Explorer', 'FREE TO JOIN', textColor, dividerColor, brandColor, mutedColor),
                _buildPackageOption('Pro', 'EARNED OR FAST-TRACK', textColor, dividerColor, brandColor, mutedColor),
                _buildPackageOption('Legend', 'EARNED ONLY', textColor, dividerColor, brandColor, mutedColor),
              ],
            ),
            
            const SizedBox(height: AppSpacing.xxxxxxxl64px),

            // PAYMENT SECTION
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
              ],
            ),
            const SizedBox(height: AppSpacing.xxxl24px),
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

            const SizedBox(height: AppSpacing.xxxxxxxl64px),

            // Total
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
              child: Divider(color: dividerColor),
            ),
            const SizedBox(height: AppSpacing.xxxl24px),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    total == 0 ? 'FREE' : 'Rp $formatter',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxxxxxxl64px),

            // Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: total == 0 ? 'Join Free' : 'Confirm Payment',
                  onPressed: () {
                    if (!AuthState.isLoggedIn.value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Anda harus Login atau Sign Up untuk melakukan pembayaran!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome to the $_selectedPackage Club!')),
                    );
                    Navigator.pop(context); // Go back to membership tab
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxxxxxxxxl128px),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color mutedColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: mutedColor,
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
          Column(
            children: children,
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor)),
          color: isSelected ? brandColor.withOpacity(0.05) : Colors.transparent,
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

  Widget _buildPackageOption(String title, String subtitle, Color textColor, Color dividerColor, Color brandColor, Color mutedColor) {
    final isSelected = _selectedPackage == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPackage = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor)),
          color: isSelected ? brandColor.withOpacity(0.05) : Colors.transparent,
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
                Text(title, style: GoogleFonts.inter(fontSize: 14, color: textColor, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
            Text(
              _packages[title] == 0 ? 'FREE' : 'Rp ${_packages[title]!}',
              style: GoogleFonts.inter(fontSize: 12, color: isSelected ? brandColor : mutedColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



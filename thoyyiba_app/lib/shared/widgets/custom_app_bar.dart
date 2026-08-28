import 'package:flutter/material.dart';
import '../../features/chat/chat_seller_dialog.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/main_layout.dart';
import 'app_navigation_menu.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const CustomAppBar({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final mainLayout = MainLayoutScreen.of(context);

    return SafeArea(
      bottom: false,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (mainLayout != null) {
                mainLayout.switchTab(0);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      onThemeToggle: onThemeToggle,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Thoyyiba',
              style: const TextStyle(fontFamily: 'Nura').copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChatSellerDialog(isDark: isDark),
                  );
                },
                child: Icon(Icons.chat_bubble_outline, color: textColor),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onThemeToggle,
                child: Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AppNavigationMenu(
                        onThemeToggle: onThemeToggle,
                        isDarkMode: isDarkMode,
                        onNavigateToShop: mainLayout != null ? () => mainLayout.switchTab(1) : null,
                        onNavigateToCart: mainLayout != null ? () => mainLayout.switchTab(3) : null,
                        onNavigateToAccount: mainLayout != null ? () => mainLayout.switchTab(4) : null,
                        onNavigateToMembership: mainLayout != null ? () => mainLayout.switchTab(5) : null,
                        onNavigateToOrders: mainLayout != null ? () => mainLayout.switchTab(6) : null,
                      ),
                    );
                },
                child: Icon(Icons.menu, color: textColor),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

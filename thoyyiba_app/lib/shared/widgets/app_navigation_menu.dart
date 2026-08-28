import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/state/cart_state.dart';
import '../../core/state/auth_state.dart';
import '../../features/home/main_layout.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/sign_up_screen.dart';

class AppNavigationMenu extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final VoidCallback? onNavigateToShop;
  final VoidCallback? onNavigateToMembership;
  final VoidCallback? onNavigateToAccount;
  final VoidCallback? onNavigateToOrders;
  final VoidCallback? onNavigateToCart;
  final VoidCallback? onNavigateToLogin;
  final VoidCallback? onNavigateToSignUp;

  const AppNavigationMenu({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
    this.onNavigateToShop,
    this.onNavigateToMembership,
    this.onNavigateToAccount,
    this.onNavigateToOrders,
    this.onNavigateToCart,
    this.onNavigateToLogin,
    this.onNavigateToSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final bgColor = isDark ? const Color(0xFF38312B) : const Color(0xFFF9F6F0);

    return Dialog.fullscreen(
      backgroundColor: bgColor,
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'Thoyyiba',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: textColor),
                onPressed: () {
                  Navigator.pop(context);
                  MainLayoutScreen.of(context)?.switchTab(2);
                },
              ),
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: textColor),
                onPressed: onThemeToggle,
              ),
              IconButton(
                icon: Icon(Icons.close, color: textColor),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: AppSpacing.md8px),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: dividerColor, height: 1),
                  const SizedBox(height: AppSpacing.xl16px),
                  _buildMenuItem('COLLECTIONS', textColor, () {
                    Navigator.pop(context);
                    if (onNavigateToShop != null) {
                      onNavigateToShop!();
                    } else {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode, initialIndex: 1)), (route) => false);
                    }
                  }),
                  _buildMenuItem('MEMBERSHIP', textColor, () {
                    Navigator.pop(context);
                    if (onNavigateToMembership != null) {
                      onNavigateToMembership!();
                    } else {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode, initialIndex: 5)), (route) => false);
                    }
                  }),
                  ValueListenableBuilder<List<CartItem>>(
                    valueListenable: CartState.items,
                    builder: (context, items, child) {
                      final count = CartState.totalItems;
                      return _buildMenuItem('CART ($count)', textColor, () {
                        Navigator.pop(context);
                        if (onNavigateToCart != null) {
                          onNavigateToCart!();
                        } else {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode, initialIndex: 3)), (route) => false);
                        }
                      });
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: AuthState.isLoggedIn,
                    builder: (context, isLoggedIn, child) {
                      if (isLoggedIn) {
                        return Column(
                          children: [
                            _buildMenuItem('MY ORDER', textColor, () {
                              Navigator.pop(context);
                              if (onNavigateToOrders != null) {
                                onNavigateToOrders!();
                              } else {
                                final layout = MainLayoutScreen.of(context); if (layout != null) { layout.switchTab(6); } else { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode, initialIndex: 6)), (route) => false); }
                              }
                            }),
                            _buildMenuItem('ACCOUNT', textColor, () {
                              Navigator.pop(context);
                              if (onNavigateToAccount != null) {
                                onNavigateToAccount!();
                              } else {
                                final layout = MainLayoutScreen.of(context); if (layout != null) { layout.switchTab(4); } else { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode, initialIndex: 4)), (route) => false); }
                              }
                            }),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildMenuItem('SIGN IN', textColor, () {
                              Navigator.pop(context);
                              if (onNavigateToLogin != null) {
                                onNavigateToLogin!();
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode)));
                              }
                            }),
                            _buildMenuItem('CREATE ACCOUNT', textColor, () {
                              Navigator.pop(context);
                              if (onNavigateToSignUp != null) {
                                onNavigateToSignUp!();
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen(onThemeToggle: onThemeToggle, isDarkMode: isDarkMode)));
                              }
                            }),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, Color textColor, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xl16px),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}




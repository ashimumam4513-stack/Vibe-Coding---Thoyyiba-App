import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/state/cart_state.dart';
import '../../core/state/auth_state.dart';
import '../../core/theme/app_tokens.dart';

class FloatingBottomNav extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingBottomNav({
    super.key,
    this.onThemeToggle,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final brandColor = theme.colorScheme.primary;

    return ValueListenableBuilder<bool>(
      valueListenable: AuthState.isLoggedIn,
      builder: (context, isLoggedIn, child) {
        final int tabCount = isLoggedIn ? 5 : 4;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl24px, vertical: AppSpacing.xxxl24px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xxxxl24px + 8),
            boxShadow: [
              // Glow effect using brand color
              BoxShadow(
                color: brandColor.withValues(alpha: isDark ? 0.2 : 0.25),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              // Base drop shadow
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xxxxl24px + 8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg12px),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A1A).withValues(alpha: 0.5) : const Color(0xFFFAF5EA).withValues(alpha: 0.65),
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / tabCount;
              return Stack(
                children: [
                  // Animated Indicator
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: 0,
                    left: currentIndex * tabWidth,
                    width: tabWidth,
                    child: Center(
                      child: Container(
                        width: 24,
                        height: 3,
                        decoration: BoxDecoration(
                          color: brandColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  // Menu Items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(context, 0, Icons.home_outlined, isDark, brandColor, tabWidth),
                      _buildNavItem(context, 1, Icons.grid_view, isDark, brandColor, tabWidth),
                      _buildNavItem(context, 2, Icons.search, isDark, brandColor, tabWidth),
                      ValueListenableBuilder<List<CartItem>>(
                        valueListenable: CartState.items,
                        builder: (context, items, child) {
                          final count = CartState.totalItems;
                          return _buildNavItem(
                            context,
                            3,
                            Icons.shopping_bag_outlined,
                            isDark,
                            brandColor,
                            tabWidth,
                            badge: count > 0 ? count.toString() : null,
                          );
                        },
                      ),
                      if (isLoggedIn)
                        _buildNavItem(context, 4, Icons.person_outline, isDark, brandColor, tabWidth),
                    ],
                  ),
                ],
              );
            },
          ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, bool isDark, Color brandColor, double width, {String? badge}) {
    final isActive = currentIndex == index;
    final defaultColor = isDark ? Colors.white54 : Colors.black54;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(AppRadius.xxl16px),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                TweenAnimationBuilder<Color?>(
                  duration: const Duration(milliseconds: 300),
                  tween: ColorTween(
                    begin: defaultColor,
                    end: isActive ? brandColor : defaultColor,
                  ),
                  builder: (context, color, child) {
                    return Icon(icon, color: color, size: 24);
                  },
                ),
                if (badge != null)
                  Positioned(
                    right: width / 2 - 20,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xs4px),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCE9B2F),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


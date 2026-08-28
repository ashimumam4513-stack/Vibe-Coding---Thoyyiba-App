import 'package:flutter/material.dart';
import '../../shared/widgets/floating_bottom_nav.dart';
import 'home_screen.dart';
import '../store/shop_screen.dart';
import '../explore/search_screen.dart';
import '../cart/cart_screen.dart';
import '../membership/membership_screen.dart';
import '../account/account_screen.dart';
import '../orders/orders_screen.dart';
import '../auth/login_screen.dart';
import '../auth/sign_up_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final int initialIndex;

  const MainLayoutScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
    this.initialIndex = 0,
  });

  static MainLayoutScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainLayoutScreenState>();
  }

  @override
  State<MainLayoutScreen> createState() => MainLayoutScreenState();
}

class MainLayoutScreenState extends State<MainLayoutScreen> {
  late int _currentIndex;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _screens = [
      HomeScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),       // 0
      ShopScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),        // 1
      SearchScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),      // 2
      CartScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),        // 3
      AccountScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),     // 4
      MembershipScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),  // 5
      OrdersScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),      // 6
      LoginScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),       // 7
      SignUpScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode),      // 8
    ];
  }

  @override
  void didUpdateWidget(MainLayoutScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDarkMode != widget.isDarkMode) {
      _screens[0] = HomeScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[1] = ShopScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[2] = SearchScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[3] = CartScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[4] = AccountScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[5] = MembershipScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[6] = OrdersScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[7] = LoginScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
      _screens[8] = SignUpScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode);
    }
  }

  // Previous tab history for back navigation
  final List<int> _tabHistory = [];

  void switchTab(int index) {
    if (_currentIndex != index) {
      _tabHistory.add(_currentIndex);
    }
    setState(() {
      _currentIndex = index;
    });
  }

  void goBack() {
    if (_tabHistory.isNotEmpty) {
      setState(() {
        _currentIndex = _tabHistory.removeLast();
      });
    } else {
      switchTab(0); // fallback to home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentIndex < 4 ? _currentIndex : (_currentIndex == 4 ? 4 : -1),
        onTap: switchTab,
        onThemeToggle: widget.onThemeToggle,
      ),
    );
  }
}

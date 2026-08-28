import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/main_layout.dart';

void main() {
  runApp(const ThoyyibaApp());
}

class ThoyyibaApp extends StatefulWidget {
  const ThoyyibaApp({super.key});

  @override
  State<ThoyyibaApp> createState() => _ThoyyibaAppState();
}

class _ThoyyibaAppState extends State<ThoyyibaApp> {
  bool isDarkMode = true; // Default to dark mode based on vibes

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thoyyiba',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainLayoutScreen(
        onThemeToggle: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}


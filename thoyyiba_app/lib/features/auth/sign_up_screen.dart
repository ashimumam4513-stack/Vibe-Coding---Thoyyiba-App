import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/floating_bottom_nav.dart';
import '../../../shared/widgets/app_footer.dart';
import 'login_screen.dart';
import '../../core/state/auth_state.dart';
import '../home/main_layout.dart'; // import to navigate to login

class SignUpScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const SignUpScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(
        onThemeToggle: widget.onThemeToggle,
        isDarkMode: widget.isDarkMode,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 120), // Padding for floating nav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              
              // Header
              Text(
                'THE CIRCLE',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: const Color(0xFFCE9B2F),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'JOIN THE RITUAL.',
                style: const TextStyle(fontFamily: 'Nura', fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5).copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Create an account to begin at Explorer tier.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 32),

              // Form Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomButton(
                      type: ButtonType.outline,
                      text: 'SIGN UP WITH GOOGLE',
                      onPressed: () {},
                        icon: Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                    ),
                    const SizedBox(height: 24),
                    
                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: theme.dividerColor.withOpacity(0.2))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: theme.dividerColor.withOpacity(0.2))),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Inputs
                    CustomTextField(controller: _nameController, label: 'Name', isRequired: true, hintText: 'Enter name', suffixIcon: const Icon(Icons.help_outline, size: 18),),
                    const SizedBox(height: 16),
                    const CustomTextField(
                      label: 'Email',
                      isRequired: true,
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.mail_outline, size: 18),
                      suffixIcon: Icon(Icons.help_outline, size: 18),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      isRequired: true,
                      hintText: 'Enter password',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Create Button
                    CustomButton(text: 'Create', onPressed: () { AuthState.userName.value = _nameController.text; AuthState.userEmail.value = _emailController.text; AuthState.isLoggedIn.value = true; final layout = MainLayoutScreen.of(context); if (layout != null) { layout.switchTab(0); } else { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode, initialIndex: 0)), (route) => false); } },),
                    const SizedBox(height: 48),

                    // Footer links
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              onThemeToggle: widget.onThemeToggle,
                              isDarkMode: widget.isDarkMode,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'HAVE AN ACCOUNT? SIGN IN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
                      child: Text(
                        '< BACK TO HOME',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          color: textColor.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
      
    );
  }
}



















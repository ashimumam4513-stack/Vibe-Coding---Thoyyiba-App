import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'login_screen.dart';
import '../home/main_layout.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty) return;
    setState(() { _isLoading = true; });
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      
      // Update display name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      if (mounted) {
        final layout = MainLayoutScreen.of(context);
        if (layout != null) {
          layout.switchTab(0);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode, initialIndex: 0)),
            (route) => false,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Sign up failed', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

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
          padding: const EdgeInsets.only(bottom: 120),
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
                'JOIN THE CLUB.',
                style: const TextStyle(fontFamily: 'Nura', fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5).copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Create an account to join Explorer tier.',
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
                      text: 'CONTINUE WITH GOOGLE',
                      onPressed: () {},
                      icon: Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                    ),
                    const SizedBox(height: 24),
                    
                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: theme.dividerColor.withValues(alpha: 0.2))),
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
                        Expanded(child: Divider(color: theme.dividerColor.withValues(alpha: 0.2))),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Inputs
                    CustomTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      isRequired: true,
                      hintText: 'Enter your full name',
                      prefixIcon: const Icon(Icons.person_outline, size: 18),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      isRequired: true,
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.mail_outline, size: 18),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      isRequired: true,
                      hintText: 'Create a password',
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

                    // Sign Up Button
                    _isLoading 
                      ? const CircularProgressIndicator() 
                      : CustomButton(text: 'Sign Up', onPressed: _signUp),
                    const SizedBox(height: 48),

                    // Footer links
                    GestureDetector(
                      onTap: () {
                        // Navigate to Login Screen
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
                        'ALREADY HAVE AN ACCOUNT? LOG IN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        final layout = MainLayoutScreen.of(context);
                        if (layout != null) { layout.switchTab(0); } else { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainLayoutScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode, initialIndex: 0)), (route) => false); }
                      },
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

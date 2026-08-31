import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'sign_up_screen.dart';
import '../home/main_layout.dart';
import '../../core/state/auth_state.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const LoginScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _navigateToHome() {
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

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) return;
    setState(() { _isLoading = true; });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) _navigateToHome();
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() { _isLoading = true; });
    try {
      final cred = await AuthState.signInWithGoogle();
      if (cred != null && mounted) _navigateToHome();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _sendMagicLink() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email first to receive the Magic Link.', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
      return;
    }
    setState(() { _isLoading = true; });
    try {
      await AuthState.sendEmailLink(_emailController.text.trim());
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Email Sent'),
            content: Text('A magic login link has been sent to ${_emailController.text}. Please check your inbox.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send link: $e', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red));
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
              
              Text(
                'THE CIRCLE',
                style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: const Color(0xFFCE9B2F)),
              ),
              const SizedBox(height: 16),
              Text(
                'WELCOME BACK.',
                style: const TextStyle(fontFamily: 'Nura', fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5).copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Sign in to your account and Explorer tier.',
                style: GoogleFonts.inter(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87),
              ),
              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomButton(
                      type: ButtonType.outline,
                      text: 'CONTINUE WITH GOOGLE',
                      onPressed: _isLoading ? () {} : _loginWithGoogle,
                      icon: Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(child: Divider(color: theme.dividerColor.withValues(alpha: 0.2))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.white38 : Colors.black38)),
                        ),
                        Expanded(child: Divider(color: theme.dividerColor.withValues(alpha: 0.2))),
                      ],
                    ),
                    const SizedBox(height: 24),

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
                      hintText: 'Enter password',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    _isLoading 
                      ? const CircularProgressIndicator() 
                      : CustomButton(text: 'Log In', onPressed: _login),
                    
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _isLoading ? null : _sendMagicLink,
                      child: Text(
                        'FORGOT PASSWORD? SEND MAGIC LINK',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: const Color(0xFFCE9B2F)),
                      ),
                    ),

                    const SizedBox(height: 48),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen(onThemeToggle: widget.onThemeToggle, isDarkMode: widget.isDarkMode)),
                        );
                      },
                      child: Text(
                        'NEW HERE? CREATE AN ACCOUNT',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: textColor.withValues(alpha: 0.7)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: _navigateToHome,
                      child: Text(
                        '< BACK TO HOME',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: textColor.withValues(alpha: 0.5)),
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

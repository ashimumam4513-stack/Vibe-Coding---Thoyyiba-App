import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Wait, it's just 'package:firebase_auth/firebase_auth.dart'

class AuthState {
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);
  static final ValueNotifier<String> userName = ValueNotifier<String>('');
  static final ValueNotifier<String> userEmail = ValueNotifier<String>('');

  static void init() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn.value = true;
        userEmail.value = user.email ?? '';
        userName.value = user.displayName ?? user.email?.split('@')[0] ?? '';
      } else {
        isLoggedIn.value = false;
        userEmail.value = '';
        userName.value = '';
      }
    });
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

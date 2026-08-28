import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_state.dart';
import 'order_state.dart';

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
        
        // Start syncing user's database
        CartState.listenToCart(user.uid);
        OrderState.listenToOrders(user.uid);
      } else {
        isLoggedIn.value = false;
        userEmail.value = '';
        userName.value = '';
        
        // Clear local memory when logged out
        CartState.stopListening();
        OrderState.stopListening();
      }
    });
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

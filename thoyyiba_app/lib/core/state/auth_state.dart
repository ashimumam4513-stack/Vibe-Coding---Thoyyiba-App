import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        
        CartState.listenToCart(user.uid);
        OrderState.listenToOrders(user.uid);
      } else {
        isLoggedIn.value = false;
        userEmail.value = '';
        userName.value = '';
        
        CartState.stopListening();
        OrderState.stopListening();
      }
    });
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null; // user canceled

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      debugPrint("Error Google SignIn: $e");
      rethrow;
    }
  }

  static Future<void> sendEmailLink(String email) async {
    final actionCodeSettings = ActionCodeSettings(
      url: 'https://thoyyiba.page.link/login', // Must match Firebase Dynamic Links / Firebase Hosting URL
      handleCodeInApp: true,
      androidPackageName: 'com.ashimumam.thoyyiba_app', // Replace with actual package name later if needed
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );
    
    // Web requires a simpler setup or a hosted URL that can handle the callback.
    // For simplicity in testing (both web & app), we use a generic URL. 
    // Usually you'll configure this URL in Firebase Console -> Authentication -> Settings -> Authorized domains.

    await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    // Save the email locally so we don't have to ask for it again when they click the link
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailForSignIn', email);
  }

  static Future<void> signInWithEmailLink(String emailLink) async {
    if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
      final prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('emailForSignIn');

      if (email == null) {
        // In a real app, if email is null, you'd prompt the user to enter their email again here.
        throw Exception('Email not found. Please enter your email again.');
      }

      await FirebaseAuth.instance.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
      
      await prefs.remove('emailForSignIn');
    } else {
      throw Exception('Invalid email link.');
    }
  }
}

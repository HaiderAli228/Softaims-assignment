import 'package:google_sign_in/google_sign_in.dart';
import '../auth-info/shared_pref_service.dart'; // Use the unified service
import 'package:flutter/material.dart';

// Configure GoogleSignIn (remove clientId for Android)
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  // For web, uncomment and provide your web client ID:
  // clientId: 'YOUR_WEB_CLIENT_ID',
);

Future<void> handleGoogleSignIn(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    ) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User canceled the sign-in.
      return;
    }
    // Get the email from the Google account.
    String email = googleUser.email;
    // Since Google Sign-In does not provide a password,
    // assign a default value (for demo purposes only).
    String defaultPassword = "defaultPassword";

    // Autofill the text fields.
    emailController.text = email;
    passwordController.text = defaultPassword;
    confirmPasswordController.text = defaultPassword;

    // Save user information using the unified SharedPrefService.
    await SharedPrefService().saveUser(
      email: email,
      password: defaultPassword,
      name: "",
      role: "",
    );
  } catch (error) {
    print("Google sign in error: $error");
  }
}

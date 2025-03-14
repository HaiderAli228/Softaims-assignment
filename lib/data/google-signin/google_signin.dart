import 'package:google_sign_in/google_sign_in.dart';
import '../auth-info/shared_pref_manager.dart';
import 'package:flutter/material.dart';

// Configure your GoogleSignIn instance; include clientId if necessary.
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  // Uncomment and set if required:
  clientId: '858621757108-pdhd3c1qgo2rsphi6cg4i2qr3tdjpnv8.apps.googleusercontent.com',
  //858621757108-pdhd3c1qgo2rsphi6cg4i2qr3tdjpnv8.apps.googleusercontent.com
);

Future<void> handleGoogleSignIn(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    ) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User canceled the sign-in
      return;
    }
    // If sign-in is successful, get the email.
    String email = googleUser.email;
    // Since Google Sign-In doesn’t provide a password,
    // assign a default or prompt the user to set one.
    String defaultPassword = "defaultPassword"; // For demo only

    // Autofill the text fields.
    emailController.text = email;
    passwordController.text = defaultPassword;
    confirmPasswordController.text = defaultPassword;

    // Save user information to Shared Preferences.
    await SharedPrefManager.saveUserInfo(email, defaultPassword);
  } catch (error) {
    print("Google sign in error: $error");
  }
}

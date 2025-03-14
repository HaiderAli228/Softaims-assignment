import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/auth-info/shared_pref_service.dart';
import '../../routes/routes_name.dart';
import '../../utils/app_colors.dart';
import '../../utils/auth_text_form_field.dart';
import '../../utils/small_widgets.dart';
import '../role-view/confirm_role_view.dart';


class CreateAccountScreen extends StatefulWidget {
  final String name;
  final UserRole role;
  const CreateAccountScreen({Key? key, required this.name, required this.role}) : super(key: key);

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _isPasswordVisible = false; // Toggle variable

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      // Save user info to shared preferences
      SharedPrefService sharedPrefService = SharedPrefService();
      await sharedPrefService.saveUser(
        _emailController.text,
        _passwordController.text,
        widget.name,
        widget.role.toString(),
      );
      // Show success toast
      Fluttertoast.showToast(
        msg: "Account created successfully. Please sign in.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      // Navigate to login screen
      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);    }
  }

  @override
  Widget build(BuildContext context) {
    // Screen dimensions for responsiveness
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundBodyColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Welcome ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                          TextSpan(
                            text: widget.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const TextSpan(
                            text: " create your account to continue with Softaims",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Email Input
                    SmallWidgets.textIs("Email Address"),
                    CustomTextField(
                      fieldValidator: MultiValidator([
                        RequiredValidator(errorText: "Email required"),
                        EmailValidator(errorText: "Enter valid email address")
                      ]).call,
                      controllerIs: _emailController,
                      focusNode: _emailFocusNode,
                      nextFocusNode: _passwordFocusNode,
                      hintTextIs: "example@gmail.com",
                      keyboardApperanceType: TextInputType.emailAddress,
                      prefixIconIs: Icons.alternate_email,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Password Input
                    SmallWidgets.textIs("Password"),
                    CustomTextField(
                      fieldValidator: MultiValidator([
                        RequiredValidator(errorText: "Password required"),
                        MinLengthValidator(8,
                            errorText: "Password must be at least 8 characters long")
                      ]).call,
                      focusNode: _passwordFocusNode,
                      keyboardApperanceType: TextInputType.emailAddress,
                      nextFocusNode: _confirmPasswordFocusNode,
                      controllerIs: _passwordController,
                      suffixIconIs: _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      prefixIconIs: Icons.lock,
                      obscureTextIs: !_isPasswordVisible,
                      onSuffixIconTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Confirm Password Input
                    SmallWidgets.textIs("Confirm password"),
                    CustomTextField(
                      fieldValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm password is required";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      keyboardApperanceType: TextInputType.emailAddress,
                      focusNode: _confirmPasswordFocusNode,
                      controllerIs: _confirmPasswordController,
                      suffixIconIs: _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      prefixIconIs: Icons.lock,
                      obscureTextIs: !_isPasswordVisible,
                      onSuffixIconTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    // Create Account Button
                    InkWell(
                      onTap: _createAccount,
                      child: Container(
                        height: screenHeight * 0.07,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.themeColor,
                        ),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: AppColors.themeTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  color: AppColors.themeColor,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement Google Sign In if needed
                          },
                          icon: const Icon(Icons.login, color: Colors.black),
                          label: const Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../../data/auth-info/shared_pref_service.dart';
import '../../routes/routes_name.dart';
import '../../utils/app_colors.dart';
import '../../utils/auth_text_form_field.dart';
import '../../utils/small_widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      SharedPrefService sharedPrefService = SharedPrefService();
      final user = await sharedPrefService.getUser();
      if (user != null) {
        if (user["email"] == _emailController.text &&
            user["password"] == _passwordController.text) {
          // Show the Lottie animation in a dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.white,
            builder: (context) {
              return Center(
                child: Lottie.asset("assets/images/second.json"),
              );
            },
          );

          // Wait for the animation to finish (or a fixed delay)
          await Future.delayed(const Duration(seconds: 2));

          // Close the dialog
          Navigator.pop(context);

          // Navigate to the home screen
          Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
        } else {
          Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "No user found. Please create an account.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingValue = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: AppColors.backgroundBodyColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                    },
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenHeight * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back, color: AppColors.themeColor),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Sign in",
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
                        TextSpan(
                          text: "Join the movement for change. Sign in to make impact on",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ),
                        TextSpan(
                          text: " GiveHope",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SmallWidgets.textIs("Email Address"),
                  CustomTextField(
                    controllerIs: _emailController,
                    fieldValidator: MultiValidator([
                      RequiredValidator(errorText: "Email required"),
                      EmailValidator(errorText: "Enter a valid email"),
                    ]).call,
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                    hintTextIs: "example@gmail.com",
                    keyboardApperanceType: TextInputType.emailAddress,
                    prefixIconIs: Icons.alternate_email,
                  ),
                  const SizedBox(height: 15),
                  SmallWidgets.textIs("Password"),
                  CustomTextField(
                    fieldValidator: MultiValidator([
                      RequiredValidator(errorText: "Password required"),
                      MinLengthValidator(8, errorText: "Password must be at least 8 characters long"),
                    ]).call,
                    focusNode: _passwordFocusNode,
                    keyboardApperanceType: TextInputType.emailAddress,
                    controllerIs: _passwordController,
                    suffixIconIs: Icons.visibility_off,
                    prefixIconIs: Icons.lock,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget password",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  InkWell(
                    onTap: _login,
                    child: Container(
                      height: screenHeight * 0.07,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.themeColor,
                      ),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: AppColors.themeTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

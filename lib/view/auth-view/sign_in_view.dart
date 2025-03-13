import 'package:assignment/routes/routes_name.dart';
import 'package:assignment/utils/app_colors.dart';
import 'package:assignment/utils/auth_text_form_field.dart';
import 'package:assignment/utils/small_widgets.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve screen size information
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the padding value based on screen width to make it more responsive
    final paddingValue = screenWidth * 0.04; // 4% of screen width

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
                      Navigator.pushReplacementNamed(
                          context, RoutesName.signupScreen);
                    },
                    child: Container(
                      height: screenHeight * 0.06, // Dynamic height
                      width: screenHeight * 0.06, // Dynamic width
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.themeColor),
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
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text:
                          "Join the movement for change. Sign in to make impact on",
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
                      MinLengthValidator(8,
                          errorText: "Password must be at least 8 characters long"),
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
                       onPressed: (){},
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.homeScreen);
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.07, // Dynamic height
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

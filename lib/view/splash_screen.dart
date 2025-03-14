import 'package:flutter/material.dart';
import '../data/auth-info/shared_pref_service.dart';
import '../routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPrefService sharedPrefService = SharedPrefService();
    final user = await sharedPrefService.getUser();

    // Delay added for a splash effect (optional)
    await Future.delayed(const Duration(seconds: 2));

    if (user != null) {
      // If user data exists, navigate to the home screen.
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    } else {
      // Otherwise, navigate to the create account screen.
      Navigator.pushReplacementNamed(context, RoutesName.createAccountScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFF48D2F0)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Softaims Assignment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "__ Haider Ali",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

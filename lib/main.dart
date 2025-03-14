import 'package:assignment/routes/routes.dart';
import 'package:assignment/routes/routes_name.dart';
import 'package:assignment/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assignment',
      home: const SplashScreen(),
      onGenerateRoute: Routes.generateRoutes,
    );

  }
}

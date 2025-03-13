import 'package:assignment/routes/routes_name.dart';
import 'package:assignment/view/auth-view/sign_in_view.dart';
import 'package:assignment/view/auth-view/sign_up_view.dart';
import 'package:flutter/material.dart';
import '../view/add_new_notes_view.dart';
import '../view/home_view.dart';
import '../view/splash_view.dart';

// Routes class manages app's navigation by generating routes based on RouteSettings
class Routes {
  // Method to generate routes based on the route name provided in RouteSettings
  static Route<bool?> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // When navigating to the Home screen
      case RoutesName.homeScreen:
        return _buildPageRoute(
          const HomeView(),
        );
      // When navigating to the Add New Notes screen
      case RoutesName.addNewScreen:
        return _buildPageRoute(
          const AddNewNotesView(),
        );
      case RoutesName.signupScreen:
        return _buildPageRoute(
          const SignUpScreen(),
        );
      case RoutesName.signinScreen:
        return _buildPageRoute(
          const SignInScreen(),
        );
      // When navigating to the Splash screen
      case RoutesName.splashScreen:
        return _buildPageRoute(
          const SplashView(),
        );
      // If the route name doesn't match any predefined routes, display a "No Route Found" screen
      default:
        return _buildPageRoute(
          const Scaffold(
            body: Center(
              child: Text(
                "No Route Found",
                style: TextStyle(fontFamily: "Poppins"),
              ),
            ),
          ),
        );
    }
  }

  // Helper method to build a PageRoute with custom slide transition animation
  static PageRouteBuilder<bool?> _buildPageRoute(Widget page) {
    return PageRouteBuilder<bool?>(
      // Specifies the widget to display when the route is pushed
      pageBuilder: (context, animation, secondaryAnimation) => page,
      // Defines how the transition animation will behave
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Animation starts from the right edge
        const end = Offset.zero; // Ends in the current view position
        const curve = Curves.easeInOut; // Specifies the curve of the animation

        // Tween defines the range of the animation from the start to end
        final tween = Tween(begin: begin, end: end);
        // CurvedAnimation adds smoothness to the transition based on the curve
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        // SlideTransition applies the sliding animation to the child widget
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}

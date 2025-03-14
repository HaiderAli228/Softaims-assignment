import 'package:flutter/material.dart';
import '../view/add_new_notes_view.dart';
import '../view/home_view.dart';
import '../view/auth-view/login_view.dart';
import '../view/auth-view/signin_view.dart';
import '../view/role-view/confirm_role_view.dart';
import 'routes_name.dart';

/// Define the slide directions for transitions.
enum SlideDirection {
  fromLeft,
  fromRight,
  fromTop,
  fromBottom,
}

class Routes {
  // Method to generate routes based on the route name provided in RouteSettings
  static Route<bool?> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
      // Here, you can choose the slide direction
        return _buildPageRoute(const HomeView(), direction: SlideDirection.fromBottom);
      case RoutesName.confirmScreen:
        return _buildPageRoute(const ConfirmRole(), direction: SlideDirection.fromTop);
      case RoutesName.addNewScreen:
        return _buildPageRoute(const AddNewNotesView(), direction: SlideDirection.fromBottom);
      case RoutesName.loginScreen:
        return _buildPageRoute(const LoginScreen(), direction: SlideDirection.fromBottom);
      case RoutesName.createAccountScreen:
        return _buildPageRoute(
          const CreateAccountScreen(name: "Haider", role: UserRole.user),
          direction: SlideDirection.fromBottom,
        );
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
          direction: SlideDirection.fromBottom,
        );
    }
  }
        // Combine a FadeTransition for smoothness with the SlideTransition.

  static PageRouteBuilder<bool?> _buildPageRoute(Widget page, {SlideDirection direction = SlideDirection.fromBottom}) {
    // Determine the start offset based on the direction.
    Offset begin;
    switch (direction) {
      case SlideDirection.fromTop:
        begin = const Offset(0, -1);
        break;
      case SlideDirection.fromLeft:
        begin = const Offset(-1, 0);
        break;
      case SlideDirection.fromRight:
        begin = const Offset(1, 0);
        break;
      case SlideDirection.fromBottom:
      default:
        begin = const Offset(0, 1);
        break;
    }

    return PageRouteBuilder<bool?>(
      // Increase the transition duration here
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define a tween that interpolates from the begin offset to zero.
        final offsetTween = Tween(begin: begin, end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOutCubic));

        // Combine a FadeTransition for smoothness with the SlideTransition.
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(offsetTween),
            child: child,
          ),
        );
      },
    );
  }

}

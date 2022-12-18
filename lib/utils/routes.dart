import 'package:go_router/go_router.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/screens/login-signup/signup.dart';
import 'package:oldbike/tab_view_controller.dart';

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/tab-view-controller',
      builder: (context, state) => const TabViewController(),
    ),
  ],
);

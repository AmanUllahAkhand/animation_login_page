import 'package:animation_login_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define the GoRouter configuration
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        // Define your routes here
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        // Add more routes as necessary
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

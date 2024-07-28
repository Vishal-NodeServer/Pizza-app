import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart'; // Update with the correct path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: "Pizza&Hungry",
      home: SplashScreen(), // SplashScreen will handle navigation to LoginPage
    );
  }
}

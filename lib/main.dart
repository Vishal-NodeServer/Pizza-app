import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash/splash_screen.dart'; // Update with the correct path

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => YourProvider(),
      child: const MyApp(),
    ),
  );
}

class YourProvider extends ChangeNotifier {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pizza App",

      home: SplashScreen(), // SplashScreen will handle navigation to LoginPage
    );
  }
}

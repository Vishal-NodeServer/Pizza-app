import 'package:flutter/material.dart';
import '/screens/auth/login_page.dart'; // Ensure this path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false, // Removes all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 56, 102),
      body: Center(
        child: Image.asset(
          "assets/loggo.png",
          width: 250.0, // Adjust this value as needed
          height: 250.0, // Adjust this value as needed
        ),
      ),
    );
  }
}

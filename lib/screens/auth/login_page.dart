import 'package:flutter/material.dart';
import 'package:food_prime_app/screens/auth/sign_up_page.dart';
import 'package:food_prime_app/screens/main/main_screen.dart';

import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart'; // Ensure this import matches your project structure

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 140),
                  const Text(
                    "Log In",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const FormContainerWidget(hintText: "Email or Username"),
                  const SizedBox(height: 20),
                  const FormContainerWidget(hintText: "Password"),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ButtonContainerWidget(
                    title: "Log In",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    },
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(
                          0xFFED6E1B), // Replace with primaryColorED6E1B if defined elsewhere
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionSignIn({required IconData iconData, required Color color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: Colors.white, // Use a defined color if available
        ),
      ),
    );
  }
}

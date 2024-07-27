import 'package:flutter/material.dart';
import 'package:food_prime_app/screens/auth/login_page.dart';
import 'package:food_prime_app/screens/main/main_screen.dart';
import 'package:food_prime_app/theme/style.dart';
import 'package:food_prime_app/widgets/button_container_widget.dart';
import 'package:food_prime_app/widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormContainerWidget(hintText: "Username"),
                const SizedBox(
                  height: 20,
                ),
                const FormContainerWidget(hintText: "Email"),
                const SizedBox(
                  height: 20,
                ),
                const FormContainerWidget(hintText: "Password"),
                const SizedBox(
                  height: 20,
                ),
                const FormContainerWidget(hintText: "Phone number"),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonContainerWidget(
                  title: "Sign Up",
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                        (route) => false);
                  },
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(fontSize: 15),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false);
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 15, color: primaryColorED6E1B),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}

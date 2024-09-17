import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/auth/login_page.dart';
import 'package:pizza_app/screens/main/nav_pages/home/home_category/Address.dart'; //import the Address.dart file

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Form key to manage form state
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // // Method to sign up using Firebase Auth
  // Future<void> _signUpWithEmailAndPassword() async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email.text,
  //       password: password.text,
  //     );
  //     // Navigate to Address Form on successful sign-up
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => AddressForm(username: username,emailController: email,passController: password,)),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     // Show error message if sign-up fails
  //     if (e.code == 'weak-password') {
  //       _showErrorDialog('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       _showErrorDialog('An account already exists for that email.');
  //     }
  //   } catch (e) {
  //     _showErrorDialog('Something went wrong. Please try again.');
  //   }
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/logoutpizza.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 400, // Adjust height as needed
            ),
          ),
          // Form container
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: username,
                      hintText: "Username",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: email,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: password,
                      hintText: "Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: phone,
                      hintText: "Phone number",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState?.validate() ?? false) {
                          //   await _signUpWithEmailAndPassword(); // Sign up with email and password
                          // }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddressForm(
                                      username: username,
                                      emailController: email,
                                      passController: password,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 56, 102),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Sign Up"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold, // bold text
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    required FormFieldValidator<String> validator, // Add validator parameter
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
      ),
      validator: validator, // Assign validator function
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/auth/sign_up_page.dart';
import 'package:pizza_app/screens/main/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form key to manage form state
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // Method to sign in using Firebase Auth
  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      User user = userCredential.user!;
      // Navigate to MainScreen on successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            user: user,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message if sign-in fails
      if (e.code == 'user-not-found') {
        _showErrorDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong password provided for that user.');
      }
    } catch (e) {
      _showErrorDialog('Something went wrong. Please try again.');
    }
  }

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
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/login_bg2.jpg', // Path to your image
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Foreground content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey, // Assign the form key
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // Semi-transparent background
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: email,
                          hintText: "Email or Username",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email or username';
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await _signInWithEmailAndPassword(); // Sign in with email and password
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 0, 27, 49),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Log In"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: divider()),
                            const SizedBox(width: 10),
                            const Text(
                              "OR",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 0, 0),
                                shadows: [
                                  Shadow(
                                    blurRadius: 7.0, // Shadow blur radius
                                    color: Color.fromARGB(
                                        255, 213, 185, 185), // Shadow color
                                    offset: Offset(5.0, 2.0), // Shadow offset
                                  ),
                                ],
                              ),
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
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(
                                      blurRadius: 7.0, // Shadow blur radius
                                      color: Colors.black, // Shadow color
                                      offset: Offset(5.0, 2.0), // Shadow offset
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
        hintStyle: const TextStyle(color: Colors.black54), // Hint text color
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.white
            .withOpacity(0.7), // Semi-transparent background for text fields
      ),
      style: const TextStyle(color: Colors.black), // Input text color
      validator: validator, // Assign validator function
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      color: Colors.black54,
    );
  }
}

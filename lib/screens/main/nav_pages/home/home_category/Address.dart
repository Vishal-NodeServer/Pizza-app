import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/auth/sign_up_page.dart'; // Import the SignUpPage
import 'package:pizza_app/screens/main/main_screen.dart'; // Import main page

class AddressForm extends StatefulWidget {
  TextEditingController username = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  AddressForm(
      {required this.username,
      required this.emailController,
      required this.passController});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to get input values
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  String? email;
  String? pass;
  Future<void> mysing(
      {String? email,
      pass,
      name,
      phone,
      street,
      city,
      state,
      postalcode}) async {
    UserCredential usercredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: pass);
    User user = usercredential.user!;
    await FirebaseFirestore.instance.collection('Data').doc(user.uid).set({
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalcode
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.emailController.text.toString();
    pass = widget.passController.text.toString();
    print('Email = $email');
    print('pass = $pass');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image
          Positioned.fill(
            child: Image.asset(
              'assets/logoutpizza.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay for better readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Form container with rounded corners
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // Slight transparency
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _nameController,
                        labelText: 'Name',
                        hintText: 'Enter your full name',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        validatorMessage:
                            'Please enter a valid 10-digit phone number',
                        customValidator: (value) =>
                            value?.length != 10 ? 'Invalid phone number' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _streetController,
                        labelText: 'Street Address',
                        hintText: 'Enter your street address',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _cityController,
                        labelText: 'City',
                        hintText: 'Enter your city',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _stateController,
                        labelText: 'State',
                        hintText: 'Enter your state',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _postalCodeController,
                        labelText: 'Postal Code',
                        hintText: 'Enter your postal code',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Process the input data
                              // final addressData = {
                              //   'name': _nameController.text,
                              //   'phone': _phoneController.text,
                              //   'street': _streetController.text,
                              //   'city': _cityController.text,
                              //   'state': _stateController.text,
                              //   'postalCode': _postalCodeController.text,
                              // };

                              // For now, print the data to the console
                              // print('Address Data: $addressData');

                              mysing(
                                  email: email,
                                  city: _cityController.text.toString(),
                                  name: _nameController.text.toString(),
                                  pass: pass,
                                  phone: _phoneController.text.toString(),
                                  postalcode:
                                      _postalCodeController.text.toString(),
                                  street: _streetController.text.toString(),
                                  state: _stateController.text.toString());
                              // Navigate to the MainScreen
                            }
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
                          child: const Text("Submit"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Back to Sign Up button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: Text(
                                "Want to change your sign-up details? ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
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
                                "Back to Sign Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? validatorMessage,
    String? Function(String?)? customValidator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage ?? 'This field cannot be empty';
        }
        if (customValidator != null) {
          return customValidator(value);
        }
        return null;
      },
    );
  }
}

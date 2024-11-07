// TODO Implement this library.import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/main/main_screen.dart';

class OrderConfirmedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Redirect to MainScreen after 1 second
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              "Order Confirmed!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

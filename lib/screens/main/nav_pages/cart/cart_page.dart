import 'package:flutter/material.dart';
import 'package:food_prime_app/screens/main/main_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _cartMainPageState();
}

class _cartMainPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 56, 102),
        centerTitle: true,
        title: const Text("Cart"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        // Your layout code here
        child: Center(
          child: Text('Welcome to Cart page'),
        ),
      ),
    );
  }
}

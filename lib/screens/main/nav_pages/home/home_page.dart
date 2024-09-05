import 'package:flutter/material.dart';
import 'package:Pizza_app/screens/main/nav_pages/home/home_category/food/food_main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/loggo.png',
              height: 50,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(
                width: 10), // Adds spacing between the image and text
            const Text(
              "PIZZA&HUNGRY",
              style: TextStyle(
                  fontSize: 20,
                  color:
                      Colors.yellow), // You can adjust the text style as needed
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 0, 56, 102),
      ),
      body: const FoodMainPage(), // Directly showing FoodMainPage
    );
  }

  Widget _homeCategoryItemWidget(
    BuildContext context, {
    required String title,
    required String description,
    required String image,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              spreadRadius: 1.5,
              blurRadius: 5.5,
              color: Colors.grey[350]!,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(image),
          ],
        ),
      ),
    );
  }
}

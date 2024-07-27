import 'package:flutter/material.dart';
import 'package:food_prime_app/screens/auth/login_page.dart';
import 'package:food_prime_app/screens/main/main_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 56, 102),
        centerTitle: true,
        title: const Text("Profile"),
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
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "vishal suthar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "vishal123suthar2@gmail.com",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "12344567890",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 1,
              color: Color.fromARGB(255, 233, 228, 228),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 15),
            _settingsItem(
              title: "Help",
              prefixIcon: Icons.help,
              onTap: () {
                // Action for Help item
              },
            ),
            const SizedBox(height: 15),
            _settingsItem(
              title: "Log out",
              prefixIcon: Icons.logout_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem({
    required String title,
    required IconData prefixIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 228, 228),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  prefixIcon,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

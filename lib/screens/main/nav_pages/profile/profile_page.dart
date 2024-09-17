import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_app/screens/auth/login_page.dart';
import 'package:pizza_app/screens/main/main_screen.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name1;

  String? email2;
  String? phone1;
  Future<void> loginget() async {
    var data = await FirebaseFirestore.instance
        .collection('Data')
        .doc(widget.user.uid)
        .get();
    setState(() {
      name1 = data['Name'];
      email2 = data['Email'];
      phone1 = data['Phone'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 56, 102),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.yellow),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: name1 == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        name1!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        email2!,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        phone1!,
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
                    title: "Call us",
                    prefixIcon: Icons.call_outlined,
                    onTap: () {
                      _makePhoneCall(
                          'tel:123456770'); // Initiate the phone call
                    },
                  ),
                  const SizedBox(height: 15),
                  _settingsItem(
                    title: "Log out",
                    prefixIcon: Icons.logout_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
    );
  }

  // Function to initiate a phone call
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

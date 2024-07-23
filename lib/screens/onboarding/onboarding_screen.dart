import 'package:flutter/material.dart';
import 'package:food_prime_app/screens/auth/login_page.dart';
import 'package:food_prime_app/screens/onboarding/onboarding_entity.dart';

import 'package:food_prime_app/widgets/button_container_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingEntity> onBoardingData = OnBoardingEntity.onBoardingData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: onBoardingData.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  // Image.asset("assets/word_app_logo.png"),

                  index == 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ButtonContainerWidget(
                            title: "pizza",
                            hasIcon: true,
                            icon: Icons.arrow_forward_ios,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            },
                            color: Colors.yellow,
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          }),
    );
  }
}

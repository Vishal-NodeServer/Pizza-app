import 'package:flutter/material.dart';

class ButtonContainerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final VoidCallback? onTap;
  final bool? hasIcon;
  final IconData? icon;
  const ButtonContainerWidget(
      {Key? key,
      this.width = double.infinity,
      this.height = 40,
      required this.title,
      this.onTap,
      this.hasIcon = false,
      this.icon,
      required MaterialColor color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 56, 102),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: hasIcon == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}

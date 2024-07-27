import 'package:flutter/material.dart';

class FormContainerWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const FormContainerWidget({Key? key, required this.hintText, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 228, 228),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}

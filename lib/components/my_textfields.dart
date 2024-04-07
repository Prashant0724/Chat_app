import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({super.key, required this.text, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          hintText: text,

        ),
        obscureText: obscureText,
        controller: controller,
      ),
    );
  }
}

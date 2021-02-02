import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final TextEditingController controller;
  final String name;

  MyText({
    this.controller,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}

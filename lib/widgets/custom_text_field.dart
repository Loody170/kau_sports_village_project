import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String textHint;
  final textController;

  CustomTextField({
    required this.textHint,
    required this.textController
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:  Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: textHint,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

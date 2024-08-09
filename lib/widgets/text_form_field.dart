import 'package:flutter/material.dart';

class TextInputForm extends StatelessWidget {
  const TextInputForm(
      {super.key,
      this.hintText,
      this.validateMessage,
      this.keyboardType,
      this.controller});

  final TextEditingController? controller;
  final String? hintText;
  final String? validateMessage;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller!.clear();
            },
            icon: const Icon(Icons.clear),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }
}

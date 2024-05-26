import 'package:flutter/material.dart';

InputDecoration inputDecoration({
  Widget? sIcon,
  required String hText,
  required IconData icon,
}) {
  return InputDecoration(
    hintText: hText,
    label: Text(hText),
    prefixIcon: Icon(icon),
    suffixIcon: sIcon,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.blue, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 1)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 1)),
  );
}

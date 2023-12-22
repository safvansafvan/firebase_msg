import 'package:flutter/material.dart';

class TextFormFieldCmn extends StatelessWidget {
  const TextFormFieldCmn(
      {super.key,
      required this.controller,
      this.prefixIcn,
      this.suffixIcn,
      required this.labelText});
  final TextEditingController controller;
  final IconData? prefixIcn;
  final IconData? suffixIcn;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcn),
            suffixIcon: Icon(suffixIcn),
            label: Text(labelText),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey))),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MaterialTextField extends StatefulWidget {
  final TextEditingController? controller;
  const MaterialTextField({super.key, this.controller});

  @override
  State<MaterialTextField> createState() => MaterialTextFieldState();
}

class MaterialTextFieldState extends State<MaterialTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(23),
      child: TextField(
        controller: widget.controller,
        maxLines: 5,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}

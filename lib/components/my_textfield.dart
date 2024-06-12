import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Color? materialcolor;
  final Color? fillColor;
  final String? labelText;
  final TextStyle? labelStylecolor;
  final TextStyle? textstylecolor;
  final TextEditingController? controller;
  final IconData? icon;
  final Color? iconcolor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  const MyTextField({
    super.key,
    this.materialcolor,
    this.fillColor,
    this.labelText,
    this.labelStylecolor,
    this.textstylecolor,
    this.controller,
    this.icon,
    this.iconcolor,
    this.keyboardType,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 20),
      child: Material(
        elevation: isSmallScreen ? 5 : 10,
        color: widget.materialcolor,
        borderRadius: BorderRadius.circular(isSmallScreen ? 5.0 : 10.0),
        child: TextField(
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          style: widget.textstylecolor,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            labelText: widget.labelText,
            labelStyle: widget.labelStylecolor,
            suffixIcon: widget.suffixIcon,
            icon: Padding(
              padding: EdgeInsets.only(left: isSmallScreen ? 10 : 15),
              child: Icon(widget.icon, color: widget.iconcolor),
            ),
          ),
        ),
      ),
    );
  }
}

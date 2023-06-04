import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.keyboardType,
      this.hideText = false,
      this.validate,
      this.preIcon})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Widget? preIcon;
  final TextInputType keyboardType;
  final bool hideText;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: TextFormField(
        validator: validate,
        obscureText: hideText,
        style: TextStyle(color: Colors.black.withOpacity(0.5)),
        cursorColor: Colors.deepOrange.shade200,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 2,
              color: Colors.deepOrange,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          labelText: labelText,
          prefixIcon: preIcon,
        ),
      ),
    );
  }
}

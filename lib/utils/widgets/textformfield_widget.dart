import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.errorText,
    this.suffixIcon,
    this.obscureText,
    this.validatorFunction,
    this.keyboardType,
    this.maxLength,
    required this.labelText,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? errorText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function(String?)? validatorFunction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 229, 221, 237),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 169, 167, 167).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: TextFormField(
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          maxLength: maxLength,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: InputDecoration(
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 13,
            ),
            hintFadeDuration: const Duration(seconds: 1),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            floatingLabelStyle: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelText: labelText, alignLabelWithHint: true,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            fillColor: const Color.fromARGB(255, 240, 234, 180),
            hintText: hintText,
            errorText: errorText, // Custom error text
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          ),
          validator: validatorFunction != null
              ? (value) => validatorFunction!(value)
              : (value) {
                  if (value == null || value.isEmpty) {
                    return errorText;
                  }
                  return null; // Valid
                },
        ),
      ),
    );
  }
}

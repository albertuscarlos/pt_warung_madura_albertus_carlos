import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool obscureText;
  final bool readOnly;
  final void Function(String)? onChanged;

  const CustomInputField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.keyboardType,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      focusNode: focusNode,
      cursorColor: Style.primaryColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Style.textFieldBorderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Style.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Style.primaryColor),
        ),
        hintText: hintText,
        hintStyle: Style.textFieldPlaceholderStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
      obscuringCharacter: '*',
      onTap: onTap,
      onChanged: onChanged,
      onTapOutside: (event) => focusNode?.unfocus(),
      validator: validator,
    );
  }
}

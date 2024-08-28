import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class FloatingCartButton extends StatelessWidget {
  final void Function() onPressed;
  const FloatingCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FloatingActionButton(
          backgroundColor: Style.primaryColor,
          onPressed: onPressed,
          child: const ImageIcon(
            AssetImage(
              'assets/icons/cart_icon.png',
            ),
            color: Style.secondaryColor,
          ),
        ),
      ),
    );
  }
}

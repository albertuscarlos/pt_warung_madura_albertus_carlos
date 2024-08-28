import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';

class BottomMenuSection extends StatelessWidget {
  final void Function() onAddCategory;
  final void Function() onAddProducts;
  const BottomMenuSection({
    super.key,
    required this.onAddCategory,
    required this.onAddProducts,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Style.secondaryColor,
      child: SizedBox(
        height: 170,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  btnText: '+ Add Category',
                  isWhiteBackground: true,
                  onPressed: onAddCategory,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  btnText: '+ Add Product',
                  isWhiteBackground: true,
                  onPressed: onAddProducts,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

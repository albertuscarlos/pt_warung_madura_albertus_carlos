import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';

class BottomMenuSection extends StatelessWidget {
  final String topButtonLabel;
  final bool isTopButtonWhite;
  final bool isBottomButtonWhite;
  final String bottomButtonLabel;
  final void Function() onPressedTopButton;
  final void Function() onPressedBottomButton;
  const BottomMenuSection({
    super.key,
    required this.onPressedTopButton,
    required this.onPressedBottomButton,
    required this.topButtonLabel,
    required this.bottomButtonLabel,
    this.isTopButtonWhite = true,
    this.isBottomButtonWhite = true,
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
                  btnText: topButtonLabel,
                  isWhiteBackground: isTopButtonWhite,
                  onPressed: onPressedTopButton,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  btnText: bottomButtonLabel,
                  isWhiteBackground: isBottomButtonWhite,
                  onPressed: onPressedBottomButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

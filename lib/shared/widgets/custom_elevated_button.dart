import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

///This custom elevated button can be used accros the UI
class CustomElevatedButton extends StatelessWidget {
  final String btnText;
  final bool isWhiteBackground;
  final void Function() onPressed;
  final bool isLoading;
  final Widget? loadingBtn;

  const CustomElevatedButton({
    super.key,
    required this.btnText,
    this.isWhiteBackground = false,
    required this.onPressed,
    this.isLoading = false,
    this.loadingBtn,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isWhiteBackground
            ? const WidgetStatePropertyAll<Color>(Style.backgroundColor)
            : null,
        shape: isWhiteBackground
            ? WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Style.primaryColor),
                ),
              )
            : null,
      ),
      child: isLoading
          ? loadingBtn
          : Text(
              btnText,
              style: Style.buttonTextStyle.copyWith(
                color: isWhiteBackground
                    ? Style.primaryColor
                    : Style.secondaryColor,
              ),
            ),
    );
  }
}

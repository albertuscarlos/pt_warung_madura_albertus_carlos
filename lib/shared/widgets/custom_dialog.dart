import 'package:flutter/material.dart';

import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogBody;
  final bool isLoading;
  const CustomDialog({
    super.key,
    this.dialogTitle = '',
    required this.dialogBody,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Style.secondaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: [
            if (!isLoading)
              Text(
                dialogTitle,
                style: Style.testRubik.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Style.primaryColor,
                ),
              ),
            const SizedBox(
              height: 50,
            ),
            Text(
              dialogBody,
              textAlign: TextAlign.center,
              style: Style.testRubik,
            ),
          ],
        ),
      ),
    );
  }
}

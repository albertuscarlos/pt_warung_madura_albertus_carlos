
import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';

class BottomsheetForm extends StatelessWidget {
  final String title;
  final Widget forms;
  final void Function() onSubmit;

  const BottomsheetForm({
    super.key,
    required this.title,
    required this.forms,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: Style.headingInterStyle,
            ),
            const SizedBox(height: 25),
            Column(children: [forms]),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                btnText: 'Submit',
                onPressed: onSubmit,
              ),
            )
          ],
        ),
      ),
    );
  }
}

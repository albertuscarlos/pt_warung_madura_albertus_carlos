import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final void Function() onPressed;
  const PaymentSuccessDialog({super.key, required this.onPressed});

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
            const SizedBox(height: 10),
            Text(
              'Payment Successfully',
              style: Style.headingInterStyle.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            const Image(
              height: 70,
              width: 70,
              image: AssetImage('assets/icons/success_icon.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                int total = 0;
                if (state is CartLoaded) {
                  total = state.total;
                }
                return Text(
                  'Rp.$total',
                  textAlign: TextAlign.center,
                  style: Style.poppinsFont,
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                btnText: 'Back to Home',
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

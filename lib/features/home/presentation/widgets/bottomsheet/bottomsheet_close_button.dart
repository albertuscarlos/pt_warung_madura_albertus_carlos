import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';

class BottomsheetCloseButton extends StatelessWidget {
  const BottomsheetCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          width: 80,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: CloseButton(
              color: const Color(0xff303030),
              onPressed: () {
                context.read<PostFormBloc>().add(ClearState());
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

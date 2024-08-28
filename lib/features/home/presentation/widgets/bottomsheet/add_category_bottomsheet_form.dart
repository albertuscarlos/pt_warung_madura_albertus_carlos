import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_input_field.dart';

class AddCategoryBottomsheetForm extends StatelessWidget {
  final TextEditingController categoryNameController;
  final FocusNode categoryNameFocus;
  const AddCategoryBottomsheetForm({
    super.key,
    required this.categoryNameController,
    required this.categoryNameFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          controller: categoryNameController,
          focusNode: categoryNameFocus,
          keyboardType: TextInputType.text,
          hintText: 'Category Name',
          onChanged: (value) {
            context.read<PostFormBloc>().add(
                  FillCategoryName(categoryName: value),
                );
          },
          validator: (String? categoryName) {
            if (categoryName != null && categoryName.isEmpty) {
              return 'Category name cannot be empty.';
            }
            return null;
          },
        )
      ],
    );
  }
}

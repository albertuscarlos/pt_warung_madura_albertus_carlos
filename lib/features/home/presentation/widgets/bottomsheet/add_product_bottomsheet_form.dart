import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/core/helper/image_picker_helper.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/home_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_input_field.dart';

class AddProductBottomsheetForm extends StatelessWidget {
  final TextEditingController productImageController,
      productNameController,
      priceController,
      productCategoryController;

  final FocusNode productNameFocus, priceFocus;

  const AddProductBottomsheetForm({
    super.key,
    required this.productImageController,
    required this.productNameController,
    required this.priceController,
    required this.productCategoryController,
    required this.productNameFocus,
    required this.priceFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PostFormBloc, PostFormState>(
          builder: (context, state) {
            String? imagePath;
            if (state is PostFillForm) {
              imagePath = state.productImage?.path.split('/').last;
            }
            return CustomInputField(
              controller: productImageController,
              keyboardType: TextInputType.text,
              hintText: imagePath ?? 'Product Image',
              readOnly: true,
              suffixIcon: const Icon(
                Icons.cloud_upload_outlined,
                color: Style.textFieldIconColor,
              ),
              onTap: () async {
                final picker = ImagePickerHelper(imagePicker: ImagePicker());
                final image = await picker.getImage();
                if (context.mounted) {
                  if (image != null) {
                    context
                        .read<PostFormBloc>()
                        .add(FillProductImage(productImage: image));
                  }
                }
              },
              validator: (String? productImage) {
                if (productImage != null && productImage.isEmpty) {
                  return 'Product image cannot be empty.';
                }
                return null;
              },
            );
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          controller: productNameController,
          focusNode: productNameFocus,
          keyboardType: TextInputType.text,
          hintText: 'Product Name',
          onChanged: (String value) {
            context.read<PostFormBloc>().add(
                  FillProductName(
                    productName: value,
                  ),
                );
          },
          validator: (String? productName) {
            if (productName != null && productName.isEmpty) {
              return 'Product name cannot be empty.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomInputField(
          controller: priceController,
          focusNode: priceFocus,
          keyboardType: TextInputType.number,
          hintText: 'Price',
          onChanged: (String value) {
            context.read<PostFormBloc>().add(
                  FillProductPrice(price: value),
                );
          },
          validator: (String? price) {
            if (price != null && price.isEmpty) {
              return 'Price cannot be empty.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            List<CategoryData> categories = [];
            if (state is ProductLoaded) {
              categories = state.categoryEntities;
            }
            return DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Style.textFieldBorderColor,
                    ),
                  ),
                  height: 55,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<PostFormBloc, PostFormState>(
                          builder: (context, state) {
                            String? categoryName;

                            if (state is PostFillForm) {
                              categoryName = state.categoryName;
                            }
                            return DropdownButton<CategoryData>(
                              iconSize: 30,
                              borderRadius: BorderRadius.circular(20),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Style.textFieldIconColor,
                                size: 22,
                              ),
                              style: Style.textFieldPlaceholderStyle
                                  .copyWith(color: Style.fontColorBlack),
                              hint: Text(
                                categoryName ?? 'Category',
                                style: Style.textFieldPlaceholderStyle,
                              ),
                              dropdownColor: Style.secondaryColor,
                              menuMaxHeight: 200,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  context.read<PostFormBloc>().add(
                                        FillProductCategory(
                                          category: newValue.id,
                                          categoryName: newValue.name,
                                        ),
                                      );
                                }
                              },
                              items: categories
                                  .map(
                                    (category) =>
                                        DropdownMenuItem<CategoryData>(
                                      value: category,
                                      child: Text(category.name),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 7)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

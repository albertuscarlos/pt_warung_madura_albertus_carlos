import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottom_menu_section.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/add_category_bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/add_product_bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/bottomsheet_close_button.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/floating_cart_button.dart';

class BottomMenus extends StatelessWidget {
  final GlobalKey<FormState> addCategoryFormKey, addProductFormKey;
  final TextEditingController categoryNameController,
      productImageController,
      productNameController,
      priceController,
      productCategoryController;
  final FocusNode categoryNameFocus, productNameFocus, priceFocus;
  const BottomMenus({
    super.key,
    required this.addCategoryFormKey,
    required this.addProductFormKey,
    required this.categoryNameController,
    required this.productImageController,
    required this.productNameController,
    required this.priceController,
    required this.productCategoryController,
    required this.categoryNameFocus,
    required this.productNameFocus,
    required this.priceFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingCartButton(
          onPressed: () => context.pushNamed('cart_page'),
        ),
        const SizedBox(height: 15),
        BottomMenuSection(
          topButtonLabel: '+ Add Category',
          bottomButtonLabel: '+ Add Product',
          onPressedTopButton: () {
            context.read<PostFormBloc>().add(FillForm());
            showBarModalBottomSheet(
              context: context,
              backgroundColor: Style.secondaryColor,
              isDismissible: false,
              topControl: const BottomsheetCloseButton(),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    child: BottomsheetForm(
                      title: 'Add Category',
                      onSubmit: () {
                        if (addCategoryFormKey.currentState?.validate() ??
                            false) {
                          context.read<PostFormBloc>().add(
                                PostFilledCategory(),
                              );
                        }
                      },
                      forms: Form(
                        key: addCategoryFormKey,
                        child: AddCategoryBottomsheetForm(
                          categoryNameController: categoryNameController,
                          categoryNameFocus: categoryNameFocus,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          onPressedBottomButton: () {
            context.read<PostFormBloc>().add(FillForm());
            showBarModalBottomSheet(
              context: context,
              backgroundColor: Style.secondaryColor,
              isDismissible: false,
              topControl: const BottomsheetCloseButton(),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    child: BottomsheetForm(
                      title: 'Add Products',
                      onSubmit: () {
                        if (addProductFormKey.currentState?.validate() ??
                            false) {
                          context.read<PostFormBloc>().add(
                                PostFilledProduct(),
                              );
                        }
                      },
                      forms: Form(
                        key: addProductFormKey,
                        child: AddProductBottomsheetForm(
                          productImageController: productImageController,
                          productNameController: productNameController,
                          priceController: priceController,
                          productCategoryController: productCategoryController,
                          productNameFocus: productNameFocus,
                          priceFocus: priceFocus,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}

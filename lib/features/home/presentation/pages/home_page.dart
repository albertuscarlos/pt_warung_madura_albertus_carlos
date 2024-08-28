import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/home_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/add_category_bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/add_product_bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottom_menu_section.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/bottomsheet_close_button.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottomsheet/bottomsheet_form.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/category_section.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/floating_cart_button.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_appbar.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController categoryNameController,
      productImageController,
      productNameController,
      priceController,
      productCategoryController;
  late FocusNode categoryNameFocus, productNameFocus, priceFocus;
  final GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

  void _fetchHomePageData() {
    Future.microtask(
      () => context.read<HomeBloc>().add(
            LoadCategoryAndProduct(),
          ),
    );
  }

  @override
  void initState() {
    super.initState();
    //Call load category and product event
    _fetchHomePageData();

    //initialize controller
    categoryNameController = TextEditingController();
    productImageController = TextEditingController();
    productNameController = TextEditingController();
    priceController = TextEditingController();
    productCategoryController = TextEditingController();

    //initialize focus
    categoryNameFocus = FocusNode();
    productNameFocus = FocusNode();
    priceFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    //dispose controller
    categoryNameController.dispose();
    productImageController.dispose();
    productNameController.dispose();
    priceController.dispose();
    productCategoryController.dispose();

    //dispose focus
    categoryNameFocus.dispose();
    productNameFocus.dispose();
    priceFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostFormBloc, PostFormState>(
      listener: (context, state) {
        if (state is PostFormSuccess) {
          context.pop();
          _fetchHomePageData();
          context.read<PostFormBloc>().add(ClearState());
          productImageController.clear();
          priceController.clear();
          productNameController.clear();
          context.pop();
        } else if (state is PostFormFailed) {
          context.pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialog(
                dialogTitle: 'Submit Failed',
                dialogBody: state.message,
              );
            },
          );
        } else if (state is PostFormLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const CustomDialog(
                isLoading: true,
                dialogBody: 'Loading...',
              );
            },
          );
        } else if (state is PostFillForm) {
          productImageController.text =
              state.productImage?.path.split('/').last ?? '';
        } else {
          productNameController.clear();
          priceController.clear();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomScrollView(
                  slivers: [
                    const CustomAppbar(appbarTitle: 'MASPOS'),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is ProductLoaded) {
                          final categories = state.categoryEntities;
                          return SliverList.separated(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final products = category.productByCategory;

                              return CategorySection(
                                categoryData: category,
                                products: products,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 30,
                              );
                            },
                          );
                        } else if (state is ProductLoading) {
                          final categories =
                              state.loadingPlaceholder.categories;
                          return Skeletonizer.sliver(
                            containersColor: Style.secondaryColor,
                            child: SliverList.separated(
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                final products = category.productByCategory;

                                return CategorySection(
                                  categoryData: category,
                                  products: products,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 30,
                                );
                              },
                            ),
                          );
                        } else if (state is ProductFailed) {
                          return SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Text(state.message),
                              ],
                            ),
                          );
                        } else {
                          return const SliverToBoxAdapter(child: SizedBox());
                        }
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 170,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingCartButton(
                    onPressed: () {},
                  ),
                  const SizedBox(height: 15),
                  BottomMenuSection(
                    onAddCategory: () {
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
                                  if (addCategoryFormKey.currentState
                                          ?.validate() ??
                                      false) {
                                    context.read<PostFormBloc>().add(
                                          PostFilledCategory(),
                                        );
                                  }
                                },
                                forms: Form(
                                  key: addCategoryFormKey,
                                  child: AddCategoryBottomsheetForm(
                                    categoryNameController:
                                        categoryNameController,
                                    categoryNameFocus: categoryNameFocus,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    onAddProducts: () {
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
                                  if (addProductFormKey.currentState
                                          ?.validate() ??
                                      false) {
                                    context.read<PostFormBloc>().add(
                                          PostFilledProduct(),
                                        );
                                  }
                                },
                                forms: Form(
                                  key: addProductFormKey,
                                  child: AddProductBottomsheetForm(
                                    productImageController:
                                        productImageController,
                                    productNameController:
                                        productNameController,
                                    priceController: priceController,
                                    productCategoryController:
                                        productCategoryController,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

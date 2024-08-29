import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';
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
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_elevated_button.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_searchbar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
      productCategoryController,
      searchController;

  late FocusNode categoryNameFocus, productNameFocus, priceFocus, searchFocus;
  final GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final ValueNotifier<bool> showSearchButton = ValueNotifier(false);

  void _fetchHomePageData() {
    Future.microtask(
      () => context.read<ProductBloc>().add(
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
    searchController = TextEditingController();

    //initialize focus
    categoryNameFocus = FocusNode();
    productNameFocus = FocusNode();
    priceFocus = FocusNode();
    searchFocus = FocusNode();
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
    searchController.dispose();

    //dispose focus
    categoryNameFocus.dispose();
    productNameFocus.dispose();
    priceFocus.dispose();
    searchFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostFormBloc, PostFormState>(
          listener: (context, state) {
            if (state is PostFormSuccess) {
              context.pop();
              _fetchHomePageData();
              context.read<PostFormBloc>().add(ClearState());
              productImageController.clear();
              priceController.clear();
              productNameController.clear();
              categoryNameController.clear();
              context.pop();
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                CustomSnackBar.success(message: state.message),
              );
            } else if (state is PostFormFailed) {
              context.pop();
              showDialog(
                context: context,
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
              categoryNameController.clear();
            }
          },
        ),
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductFailed<ProductLoaded>) {
              context.pop();
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                CustomSnackBar.error(message: state.message),
              );
            } else if (state is ProductDeleted) {
              context.pop();
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                const CustomSnackBar.success(message: 'Delete Product Success'),
              );
              _fetchHomePageData();
            } else if (state is ProductLoading<List<CategoryData>>) {
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
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is HomeCartLoading) {
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
            } else if (state is CartSuccess) {
              context.pop();
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                const CustomSnackBar.success(message: 'Added to cart.'),
              );
            } else if (state is CartFailed) {
              context.pop();
              showTopSnackBar(
                displayDuration: const Duration(seconds: 1),
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: 'Failed add product to cart.',
                ),
              );
            }
          },
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomScrollView(
                  slivers: [
                    ValueListenableBuilder(
                      valueListenable: showSearchButton,
                      builder: (context, value, child) {
                        return CustomAppbar(
                          appbarTitle: 'MASPOS',
                          isSuffixTapped: value,
                          onTapSuffix: () {
                            showSearchButton.value = !showSearchButton.value;
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: showSearchButton,
                      builder: (context, searchButton, child) {
                        if (searchButton == true) {
                          return SliverToBoxAdapter(
                            child: Column(
                              children: [
                                CustomSearchBar(
                                  controller: searchController,
                                  focusNode: searchFocus,
                                  onChanged: (valuie) {
                                    context.read<ProductBloc>().add(
                                        SearchProduct(searchKeyword: valuie));
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SliverToBoxAdapter(child: SizedBox());
                        }
                      },
                    ),
                    // const SliverToBoxAdapter(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Icon(
                    //         Icons.filter_alt_outlined,
                    //         color: Style.textFieldBorderColor,
                    //         size: 30,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     height: 10,
                    //   ),
                    // ),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        //define variable for state
                        List<CategoryData> categories = [];
                        String? message;
                        bool? isSkeletonEnabled;

                        //fill variable from the product state
                        if (state is ProductLoaded) {
                          categories = state.categoryEntities;
                        } else if (state is ProductDeleted) {
                          categories = state.categoryEntities;
                        } else if (state
                            is ProductLoading<List<CategoryData>>) {
                          final placeholder = state.loadingPlaceholder;
                          if (placeholder != null) {
                            categories = placeholder;
                          }
                        } else if (state is ProductLoading<CategoryEntities>) {
                          final placeholder = state.loadingPlaceholder;
                          if (placeholder != null) {
                            categories = placeholder.categories;
                            isSkeletonEnabled = true;
                          }
                        } else if (state is ProductFailed<ProductLoaded>) {
                          final previousState = state.previousState;
                          if (previousState != null) {
                            categories = previousState.categoryEntities;
                          } else {
                            message = state.message;
                          }
                        } else if (state is ProductFailed) {
                          message = state.message;
                        }

                        //build the UI
                        if (categories.isNotEmpty) {
                          return Skeletonizer.sliver(
                            enabled: isSkeletonEnabled ?? false,
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
                        } else if (message != null) {
                          return SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                ),
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: Style.rubikFont,
                                ),
                                const SizedBox(height: 40),
                                CustomElevatedButton(
                                  btnText: 'Try Again',
                                  onPressed: () {
                                    _fetchHomePageData();
                                  },
                                ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/post_form/post_form_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottom_menus.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/category_section.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/empty_category_section.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/fliter_list.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_appbar.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_dialog.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_drawer.dart';
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
  final ValueNotifier<bool> showFilterOption = ValueNotifier(false);
  final ValueNotifier<bool> onTapNewestProduct = ValueNotifier(false);
  final ValueNotifier<bool> onTapOldestProduct = ValueNotifier(false);

  void _fetchHomePageData() {
    Future.microtask(
      () => context.read<ProductBloc>().add(
            LoadCategoryAndProduct(),
          ),
    );
  }

  //handle post form listener here
  void _postFormListener(BuildContext context, PostFormState state) {
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
  }

  //handle product bloc listener
  void _productBlocListener(BuildContext context, ProductState state) {
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
    } else if (state is ProductLoaded) {
      if (state.filterOption == FilterOption.newestProduct) {
        onTapNewestProduct.value = true;
        onTapOldestProduct.value = false;
      } else if (state.filterOption == FilterOption.oldestProduct) {
        onTapNewestProduct.value = false;
        onTapOldestProduct.value = true;
      }
    }
  }

  // _handle cart bloc listener
  void _cartBlocListener(BuildContext context, CartState state) {
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
        BlocListener<PostFormBloc, PostFormState>(listener: _postFormListener),
        BlocListener<ProductBloc, ProductState>(listener: _productBlocListener),
        BlocListener<CartBloc, CartState>(listener: _cartBlocListener)
      ],
      child: Scaffold(
        drawer: const SafeArea(
          child: Drawer(
            backgroundColor: Style.backgroundColor,
            child: CustomDrawer(),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: RefreshIndicator(
                  onRefresh: () async => _fetchHomePageData(),
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
                              // showFilterOption.value = false;
                              context.read<ProductBloc>().add(
                                    SearchProduct(
                                      searchKeyword: searchController.text = '',
                                    ),
                                  );
                            },
                            onTapFilter: () {
                              showFilterOption.value = !showFilterOption.value;
                              context.read<ProductBloc>().add(
                                    SearchProduct(
                                      searchKeyword: searchController.text = '',
                                    ),
                                  );
                              // showSearchButton.value = false;
                            },
                          );
                        },
                      ),
                      //handle state change when search button tapped
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
                      ValueListenableBuilder(
                        valueListenable: showFilterOption,
                        builder: (context, value, child) {
                          if (value == true) {
                            return FliterList(
                              onTapNewestProduct: onTapNewestProduct,
                              onTapOldestProduct: onTapOldestProduct,
                            );
                          } else {
                            return const SliverToBoxAdapter(child: SizedBox());
                          }
                        },
                      ),
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
                          } else if (state
                              is ProductLoading<CategoryEntities>) {
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
                          } else if (categories.isEmpty) {
                            return const EmptyCategorySection();
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
              ),
              BottomMenus(
                addCategoryFormKey: addCategoryFormKey,
                addProductFormKey: addProductFormKey,
                categoryNameController: categoryNameController,
                productImageController: productImageController,
                productNameController: productNameController,
                priceController: priceController,
                productCategoryController: productCategoryController,
                categoryNameFocus: categoryNameFocus,
                productNameFocus: productNameFocus,
                priceFocus: priceFocus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

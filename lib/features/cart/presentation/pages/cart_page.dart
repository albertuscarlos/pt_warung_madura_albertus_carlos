import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/domain/entities/cart_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/widgets/empty_cart_placeholder.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/widgets/order_card.dart';
import 'package:pt_warung_madura_albertus_carlos/features/cart/presentation/widgets/order_total_card.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/widgets/bottom_menu_section.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_appbar.dart';
import 'package:pt_warung_madura_albertus_carlos/shared/widgets/custom_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _fetchCartData() {
    Future.microtask(() => context.read<CartBloc>().add(LoadCartProduct()));
  }

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomScrollView(
                slivers: [
                  const CustomAppbar(
                    appbarTitle: 'Cart',
                    showSuffixIcon: false,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      List<CartData> cartDataList = [];
                      bool isLoading = false;

                      if (state is CartLoaded) {
                        cartDataList = state.cartData;
                      } else if (state is CartLoading) {
                        cartDataList = state.placeholder;
                        isLoading = true;
                      }

                      if (cartDataList.isNotEmpty) {
                        return Skeletonizer.sliver(
                          enabled: isLoading,
                          child: SliverList.separated(
                            itemCount: cartDataList.length,
                            itemBuilder: (context, index) {
                              final cartData = cartDataList[index];
                              return OrderCard(cartData: cartData);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 30);
                            },
                          ),
                        );
                      } else {
                        return const EmptyCartPlaceholder();
                      }
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int? total;
                      List<CartData> cartData = [];
                      bool isLoading = false;

                      if (state is CartLoaded) {
                        total = state.total;
                        cartData = state.cartData;
                      } else if (state is CartLoading) {
                        cartData = state.placeholder;
                        isLoading = true;
                      }

                      if (cartData.isNotEmpty) {
                        return Skeletonizer.sliver(
                          enabled: isLoading,
                          child: OrderTotalCard(total: total ?? 0),
                        );
                      } else {
                        return const SliverToBoxAdapter(child: SizedBox());
                      }
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomMenuSection(
                  onPressedTopButton: () {},
                  onPressedBottomButton: () => context.pop(),
                  isTopButtonWhite: false,
                  topButtonLabel: 'Pay Bill',
                  bottomButtonLabel: 'Back to Home',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

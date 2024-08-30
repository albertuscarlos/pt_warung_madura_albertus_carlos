import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';

class FliterList extends StatelessWidget {
  const FliterList(
      {super.key,
      required this.onTapNewestProduct,
      required this.onTapOldestProduct});

  final ValueNotifier<bool> onTapNewestProduct;
  final ValueNotifier<bool> onTapOldestProduct;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductLoaded) {}
      },
      child: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: onTapOldestProduct,
                  builder: (context, value, child) {
                    return FilterChip(
                      backgroundColor: Style.secondaryColor,
                      selected: value,
                      label: Text(
                        'Oldest Product',
                        style: Style.buttonTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      onSelected: (value) {
                        onTapNewestProduct.value = false;
                        onTapOldestProduct.value = !onTapOldestProduct.value;
                        context.read<ProductBloc>().add(
                              const SortProductByDate(
                                filterOption: FilterOption.oldestProduct,
                              ),
                            );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ValueListenableBuilder(
                  valueListenable: onTapNewestProduct,
                  builder: (context, value, child) {
                    return FilterChip(
                      selected: value,
                      backgroundColor: Style.secondaryColor,
                      label: Text(
                        'Newest Product',
                        style: Style.buttonTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      onSelected: (value) {
                        onTapNewestProduct.value = !onTapNewestProduct.value;
                        onTapOldestProduct.value = false;
                        context.read<ProductBloc>().add(
                              const SortProductByDate(
                                filterOption: FilterOption.newestProduct,
                              ),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

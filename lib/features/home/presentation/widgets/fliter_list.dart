import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/presentation/bloc/product/product_bloc.dart';

class FliterList extends StatelessWidget {
  FliterList({super.key});

  final ValueNotifier<bool> onTapNewestProduct = ValueNotifier(false);
  final ValueNotifier<bool> onTapOldestProduct = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [
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
              const SizedBox(
                width: 10,
              ),
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
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

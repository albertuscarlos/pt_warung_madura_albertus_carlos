import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/core/constants/dummy_data.dart';
import 'package:pt_warung_madura_albertus_carlos/core/utils/app_enum.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/delete_product.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetCategory getCategory;
  final GetProducts getProducts;
  final DeleteProduct deleteProduct;
  ProductBloc({
    required this.getCategory,
    required this.getProducts,
    required this.deleteProduct,
  }) : super(HomeInitial()) {
    on<LoadCategoryAndProduct>(
      (event, emit) async {
        emit(ProductLoading<CategoryEntities>(
            loadingPlaceholder: DummyData.categoryDummy));

        final categoryResult = await getCategory.execute();

        await categoryResult.fold(
          (failed) {
            emit(ProductFailed(message: failed.message));
          },
          (categorySuccess) async {
            final productResult = await getProducts.execute();

            productResult.fold(
              (failed) => emit(ProductFailed(message: failed.message)),
              (productSuccess) {
                // filter product by category id
                final categoryWithProduct = categorySuccess.categories.map(
                  (category) {
                    final products = productSuccess.products;
                    final filteredProduct = products.where(
                      (product) {
                        return product.categoryId == category.id;
                      },
                    ).toList();

                    // retun category entities with filtered product
                    return category.copyWith(
                      productByCategory: filteredProduct,
                    );
                  },
                ).toList();
                //emit success state
                emit(
                  ProductLoaded(
                    products: categoryWithProduct,
                    searchCategory: categoryWithProduct,
                    categoryEntities: categoryWithProduct,
                    productEntities: productSuccess.products,
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<DeleteSelectedProduct>((event, emit) async {
      //Delete when state is product loaded
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        emit(ProductLoading<List<CategoryData>>(
          loadingPlaceholder: currentState.categoryEntities,
        ));

        final request = await deleteProduct.execute(productId: event.productId);

        request.fold(
          (failed) => emit(
            ProductFailed<ProductLoaded>(
              message: failed.message,
              previousState: currentState,
            ),
          ),
          (success) => emit(
            ProductDeleted(
              categoryEntities: currentState.categoryEntities,
              productEntities: currentState.productEntities,
            ),
          ),
        );

        //Delete when state is productfailed
      } else if (state is ProductFailed<ProductLoaded>) {
        log(event.productId);
        final currentState = state as ProductFailed<ProductLoaded>;
        emit(ProductLoading<List<CategoryData>>(
          loadingPlaceholder: currentState.previousState?.categoryEntities,
        ));

        final result = await deleteProduct.execute(productId: event.productId);

        result.fold((failed) {
          emit(
              currentState.copyWith(previousState: currentState.previousState));
        }, (success) {
          emit(ProductDeleted(
            categoryEntities: currentState.previousState!.categoryEntities,
            productEntities: currentState.previousState!.productEntities,
          ));
        });
      }
    });

    on<SearchProduct>((event, emit) async {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        //search product
        final searchCategory = currentState.searchCategory.map((elements) {
          final data = elements.productByCategory!
              .where((data) => data.name
                  .toLowerCase()
                  .contains(event.searchKeyword.toLowerCase()))
              .toList();

          return elements.copyWith(productByCategory: data);
        }).toList();

        //filter if searched product is null
        final categories = searchCategory.where((data) {
          final products = data.productByCategory;
          return products != null && products.isNotEmpty;
        }).toList();

        //if search keyword is not null emit filtered
        if (event.searchKeyword != '') {
          emit(
            currentState.copyWith(
              categoryEntities:
                  event.searchKeyword != '' ? categories : searchCategory,
            ),
          );
        } else if (event.searchKeyword == '') {
          emit(
            currentState.copyWith(
              categoryEntities: currentState.products,
              filterOption: FilterOption.oldestProduct,
            ),
          );
        }
      }
    });

    on<SortProductByDate>((event, emit) async {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        List<CategoryData> sortedCategories;
        FilterOption? filterOption;

        if (event.filterOption == FilterOption.newestProduct) {
          sortedCategories = currentState.categoryEntities.map((category) {
            final sortedProducts =
                List<ProductData>.from(category.productByCategory!)
                  ..sort((b, a) => a.createdAt.compareTo(b.createdAt));
            return category.copyWith(productByCategory: sortedProducts);
          }).toList();
          filterOption = FilterOption.newestProduct;
        } else {
          sortedCategories = currentState.categoryEntities.map((category) {
            final sortedProducts =
                List<ProductData>.from(category.productByCategory!)
                  ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
            return category.copyWith(productByCategory: sortedProducts);
          }).toList();
          filterOption = FilterOption.oldestProduct;
        }

        emit(
          currentState.copyWith(
            categoryEntities: sortedCategories,
            searchCategory: sortedCategories,
            filterOption: filterOption,
          ),
        );
      }
    });
  }
}

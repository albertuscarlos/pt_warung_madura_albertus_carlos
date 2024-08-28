import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/core/constants/dummy_data.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/get_products.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategory getCategory;
  final GetProducts getProducts;
  HomeBloc({
    required this.getCategory,
    required this.getProducts,
  }) : super(HomeInitial()) {
    on<LoadCategoryAndProduct>(
      (event, emit) async {
        emit(ProductLoading(loadingPlaceholder: DummyData.categoryDummy));

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
  }
}

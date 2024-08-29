import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/category_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/entities/product_body_entities.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_category.dart';
import 'package:pt_warung_madura_albertus_carlos/features/home/domain/usecases/post_product.dart';

part 'post_form_event.dart';
part 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final PostCategory postCategory;
  final PostProduct postProduct;
  PostFormBloc({
    required this.postCategory,
    required this.postProduct,
  }) : super(PostFormInitial()) {
    //to reset state
    on<ClearState>((event, emit) {
      emit(PostFormInitial());
    });

    //to initiate state
    on<FillForm>((event, emit) {
      if (state is! PostFillForm) {
        emit(const PostFillForm());
        log('Start Fill');
      }
    });

    //to handle category bottomsheet
    on<FillCategoryName>((event, emit) {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        emit(currentState.copyWith(categoryName: event.categoryName));
      } else if (state is PostFormFailed<PostFillForm>) {
        final currentState = state as PostFormFailed<PostFillForm>;

        emit(currentState.previousState.copyWith(
          categoryName: event.categoryName,
        ));
      }
    });

    on<PostFilledCategory>((event, emit) async {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;
        emit(PostFormLoading());

        final request = await postCategory.execute(
          categoryBody: CategoryBodyEntities(
            categoryName: currentState.categoryName ?? '',
          ),
        );

        request.fold(
          (failed) {
            emit(PostFormFailed(
              message: failed.message,
              previousState: currentState,
            ));
          },
          (success) => emit(PostFormSuccess(message: success)),
        );
      } else if (state is PostFormFailed<PostFillForm>) {
        final currentState = state as PostFormFailed<PostFillForm>;
        emit(PostFormLoading());

        final request = await postCategory.execute(
          categoryBody: CategoryBodyEntities(
            categoryName: currentState.previousState.categoryName ?? '',
          ),
        );

        request.fold(
          (failed) {
            emit(PostFormFailed(
              message: failed.message,
              previousState: currentState.previousState,
            ));
          },
          (success) => emit(PostFormSuccess(message: success)),
        );
      }
    });

    //to fill product bottomsheet

    on<PostFilledProduct>((event, emit) async {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        emit(PostFormLoading());

        final result = await postProduct.execute(
          productBody: ProductBodyEntities(
            productImage: currentState.productImage,
            productName: currentState.productName,
            price: currentState.price,
            category: currentState.category,
          ),
        );

        result.fold(
          (failure) => emit(PostFormFailed(
            message: failure.message,
            previousState: currentState,
          )),
          (success) => emit(PostFormSuccess(message: success)),
        );
      } else if (state is PostFormFailed<PostFillForm>) {
        final currentState = state as PostFormFailed<PostFillForm>;

        emit(PostFormLoading());

        final result = await postProduct.execute(
          productBody: ProductBodyEntities(
            productImage: currentState.previousState.productImage,
            productName: currentState.previousState.productName,
            price: currentState.previousState.price,
            category: currentState.previousState.category,
          ),
        );

        result.fold(
          (failure) => emit(PostFormFailed(
            message: failure.message,
            previousState: currentState.previousState,
          )),
          (success) => emit(PostFormSuccess(message: success)),
        );
      }
    });
    on<FillProductImage>((event, emit) {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        emit(currentState.copyWith(productImage: event.productImage));
      } else if (state is PostFormFailed) {
        final currentState = state as PostFormFailed<PostFillForm>;

        emit(currentState.previousState
            .copyWith(productImage: event.productImage));
      }
    });
    on<FillProductName>((event, emit) {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        emit(currentState.copyWith(productName: event.productName));
      } else if (state is PostFormFailed) {
        final currentState = state as PostFormFailed<PostFillForm>;

        emit(currentState.previousState
            .copyWith(productName: event.productName));
      }
    });
    on<FillProductPrice>((event, emit) {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        final parsePrice = num.parse(event.price);

        emit(currentState.copyWith(price: parsePrice));
      } else if (state is PostFormFailed) {
        final currentState = state as PostFormFailed<PostFillForm>;

        final parsePrice = num.parse(event.price);
        emit(currentState.previousState.copyWith(
          price: parsePrice,
        ));
      }
    });
    on<FillProductCategory>((event, emit) {
      if (state is PostFillForm) {
        final currentState = state as PostFillForm;

        emit(
          currentState.copyWith(
            category: event.category,
            categoryName: event.categoryName,
          ),
        );
      } else if (state is PostFormFailed) {
        final currentState = state as PostFormFailed<PostFillForm>;

        emit(
          currentState.previousState.copyWith(
            category: event.category,
            categoryName: event.categoryName,
          ),
        );
      }
    });
  }
}

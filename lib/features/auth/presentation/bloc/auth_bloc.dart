import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/get_token.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/logout.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/post_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PostLogin postLogin;
  final GetToken getToken;
  final AuthLogout authLogout;
  AuthBloc({
    required this.postLogin,
    required this.getToken,
    required this.authLogout,
  }) : super(AuthInitial()) {
    on<SignIn>((event, emit) async {
      emit(AuthLoading());

      final result =
          await postLogin.execute(loginBodyModels: event.loginBodyModels);

      result.fold((failed) {
        emit(AuthFailure(message: failed.message));
      }, (success) {
        emit(UserSignedIn());
      });
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoading());

      final result = await authLogout.execute();

      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (success) => emit(
          UserSignedOut(),
        ),
      );
    });

    on<AuthenticationCheck>((event, emit) async {
      emit(AuthLoading());

      final result = await getToken.execute();

      await Future.delayed(const Duration(seconds: 1));

      result.fold((failure) {
        emit(UserSignedOut());
      }, (success) {
        emit(UserSignedIn());
      });
    });
  }
}

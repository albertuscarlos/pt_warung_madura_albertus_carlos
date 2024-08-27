import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/data/models/login_body_models.dart';
import 'package:pt_warung_madura_albertus_carlos/features/auth/domain/usecases/post_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PostLogin postLogin;
  AuthBloc({
    required this.postLogin,
  }) : super(AuthInitial()) {
    on<PostLoginData>((event, emit) async {
      emit(AuthLoading());

      final result =
          await postLogin.execute(loginBodyModels: event.loginBodyModels);

      result.fold((failed) {
        emit(AuthFailure(message: failed.message));
      }, (success) {
        emit(AuthSuccess());
      });
    });
  }
}

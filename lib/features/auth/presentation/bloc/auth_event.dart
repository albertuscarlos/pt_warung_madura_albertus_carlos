part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignIn extends AuthEvent {
  final LoginBodyModels loginBodyModels;

  const SignIn({required this.loginBodyModels});

  @override
  List<Object> get props => [loginBodyModels];
}

final class SignOut extends AuthEvent {}

final class AuthenticationCheck extends AuthEvent {}

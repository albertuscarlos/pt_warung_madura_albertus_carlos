part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class PostLoginData extends AuthEvent {
  final LoginBodyModels loginBodyModels;

  const PostLoginData({required this.loginBodyModels});

  @override
  List<Object> get props => [loginBodyModels];
}

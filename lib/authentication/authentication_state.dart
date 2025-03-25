import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/login_model.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final LoginModel user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  final String? message;

  const AuthenticationFailure({@required this.message});

  @override
  List<Object?> get props => [message];
}

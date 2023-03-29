part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthUninitialized extends AuthInitial {}

class AuthAuthenticated extends AuthInitial {}

class AuthUnauthenticated extends AuthInitial {}

class AuthLoading extends AuthInitial {}
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckStatus extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  const AuthRegisterRequested({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [name, username, email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;
  const AuthForgotPasswordRequested({required this.email});
  @override
  List<Object?> get props => [email];
}

class AuthChangePasswordRequested extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  const AuthChangePasswordRequested({required this.oldPassword, required this.newPassword});
  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class AuthDeleteAccountRequested extends AuthEvent {}

class AuthUserUpdated extends AuthEvent {
  final UserModel user;
  const AuthUserUpdated(this.user);
  @override
  List<Object?> get props => [user];
}

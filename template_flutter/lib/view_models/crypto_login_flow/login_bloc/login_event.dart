part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginRememberMeChanged extends LoginEvent {
  final bool rememberMe;
  final ValueChanged<bool> rememberMeChanged;
  LoginRememberMeChanged(this.rememberMe, this.rememberMeChanged);
  @override
  List<Object?> get props => [rememberMe, rememberMeChanged];
}

class LoginClicked extends LoginEvent {
  final LoginCallback onLoginClicked;
  LoginClicked(this.onLoginClicked);
  @override
  List<Object?> get props => [onLoginClicked];
}

class LoginForgotPasswordClicked extends LoginEvent {
  final Future<bool?> Function() onForgotPasswordClicked;
  LoginForgotPasswordClicked(this.onForgotPasswordClicked);
  @override
  List<Object?> get props => [onForgotPasswordClicked];
}

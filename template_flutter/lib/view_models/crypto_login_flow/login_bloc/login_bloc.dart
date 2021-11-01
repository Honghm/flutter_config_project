import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:template_flutter/views/crypto_login_flow/login_screen.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final RegExp passReg = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  LoginBloc() : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      bool result = emailReg.hasMatch(event.email);
      if (!result) {
        emit(state.copyWith(
            emailValidator: "Invalid Email", email: event.email));
      } else {
        emit(state.copyWith(emailValidator: "", email: event.email));
      }
    });
    on<LoginPasswordChanged>((event, emit) {
      if (!passReg.hasMatch(event.password)) {
        emit(state.copyWith(
            passwordValidator: "Invalid Password", password: event.password));
      } else {
        emit(state.copyWith(passwordValidator: "", password: event.password));
      }
    });
    on<LoginRememberMeChanged>((event, emit) {
      emit(state.copyWith(rememberMe: event.rememberMe));
    });
    on<LoginClicked>((event, emit) async {
      if (!passReg.hasMatch(state.password) || !emailReg.hasMatch(state.email))
        return;

      emit(state.copyWith(buttonStatus: ButtonStatus.loading));
      await event.onLoginClicked(
        state.email,
        state.password,
        () {
          emit(state.copyWith(buttonStatus: ButtonStatus.success));
        },
        () {
          emit(state.copyWith(buttonStatus: ButtonStatus.fail));
        },
      );
      print(state.buttonStatus);

      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(buttonStatus: ButtonStatus.idle));
    });
    on<LoginForgotPasswordClicked>((event, emit) {
      event.onForgotPasswordClicked();
    });
  }
}

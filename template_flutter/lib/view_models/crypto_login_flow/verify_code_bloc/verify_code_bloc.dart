import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/flutter_template.dart';

part 'verify_code_event.dart';
part 'verify_code_state.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  VerifyCodeBloc() : super(VerifyCodeState.initial()) {
    on<VerifyCodeChanged>((event, emit) {
      emit(state.copyWith(code: event.code));
    });

    on<VerifyCodeSubmitted>((event, emit) async {
      emit(state.copyWith(buttonStatus: ButtonStatus.loading));
      if (await event.onVerify(state.code)) {
        emit(state.copyWith(buttonStatus: ButtonStatus.success));
      } else {
        emit(state.copyWith(buttonStatus: ButtonStatus.fail));
      }
      await Future.delayed(
        Duration(seconds: 2),
      );
      emit(state.copyWith(buttonStatus: ButtonStatus.idle));
    });
  }
}

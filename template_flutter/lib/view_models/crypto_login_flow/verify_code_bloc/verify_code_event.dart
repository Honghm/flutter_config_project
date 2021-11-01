part of 'verify_code_bloc.dart';

abstract class VerifyCodeEvent extends Equatable {
  const VerifyCodeEvent();
}

class VerifyCodeChanged extends VerifyCodeEvent {
  final String code;

  VerifyCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class VerifyCodeSubmitted extends VerifyCodeEvent {
  final Future<bool> Function(String code) onVerify;
  VerifyCodeSubmitted(this.onVerify);

  @override
  List<Object?> get props => [onVerify];
}

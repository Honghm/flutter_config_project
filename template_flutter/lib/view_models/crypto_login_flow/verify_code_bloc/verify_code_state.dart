part of 'verify_code_bloc.dart';

class VerifyCodeState extends Equatable {
  final ButtonStatus buttonStatus;
  final String code;
  @override
  List<Object?> get props => [
        buttonStatus,
        code,
      ];

  //<editor-fold desc="Data Methods">

  const VerifyCodeState({
    required this.buttonStatus,
    required this.code,
  });
  factory VerifyCodeState.initial() =>
      VerifyCodeState(buttonStatus: ButtonStatus.idle, code: "");

  @override
  String toString() {
    return 'VerifyCodeState{' +
        ' buttonStatus: $buttonStatus,' +
        ' code: $code,' +
        '}';
  }

  VerifyCodeState copyWith({
    ButtonStatus? buttonStatus,
    String? code,
  }) {
    return VerifyCodeState(
      buttonStatus: buttonStatus ?? this.buttonStatus,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buttonStatus': this.buttonStatus,
      'code': this.code,
    };
  }

  factory VerifyCodeState.fromMap(Map<String, dynamic> map) {
    return VerifyCodeState(
      buttonStatus: map['buttonStatus'] as ButtonStatus,
      code: map['code'] as String,
    );
  }

  //</editor-fold>
}

part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;
  final ButtonStatus buttonStatus;
  final String emailValidator;
  final String passwordValidator;
  @override
  List<Object?> get props => [
        email,
        password,
        rememberMe,
        buttonStatus,
        emailValidator,
        passwordValidator,
      ];
  factory LoginState.initial() => LoginState(
        email: '',
        password: "",
        buttonStatus: ButtonStatus.idle,
        rememberMe: false,
        emailValidator: "",
        passwordValidator: "",
      );
//<editor-fold desc="Data Methods">

  const LoginState({
    required this.email,
    required this.password,
    required this.rememberMe,
    required this.buttonStatus,
    required this.emailValidator,
    required this.passwordValidator,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          rememberMe == other.rememberMe &&
          buttonStatus == other.buttonStatus &&
          emailValidator == other.emailValidator &&
          passwordValidator == other.passwordValidator);

  @override
  int get hashCode =>
      email.hashCode ^
      password.hashCode ^
      rememberMe.hashCode ^
      buttonStatus.hashCode ^
      emailValidator.hashCode ^
      passwordValidator.hashCode;

  @override
  String toString() {
    return 'LoginState{' +
        ' email: $email,' +
        ' password: $password,' +
        ' rememberMe: $rememberMe,' +
        ' buttonStatus: $buttonStatus,' +
        ' emailValidator: $emailValidator,' +
        ' passwordValidator: $passwordValidator,' +
        '}';
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    ButtonStatus? buttonStatus,
    String? emailValidator,
    String? passwordValidator,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      emailValidator: emailValidator ?? this.emailValidator,
      passwordValidator: passwordValidator ?? this.passwordValidator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'rememberMe': this.rememberMe,
      'buttonStatus': this.buttonStatus,
      'emailValidator': this.emailValidator,
      'passwordValidator': this.passwordValidator,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      email: map['email'] as String,
      password: map['password'] as String,
      rememberMe: map['rememberMe'] as bool,
      buttonStatus: map['buttonStatus'] as ButtonStatus,
      emailValidator: map['emailValidator'] as String,
      passwordValidator: map['passwordValidator'] as String,
    );
  }

//</editor-fold>
}

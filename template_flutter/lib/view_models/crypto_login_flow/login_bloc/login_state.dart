part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;
  final ButtonStatus buttonStatus;
  final String emailValidator;
  final String passwordValidator;
  final bool isNotification;
  @override
  List<Object?> get props => [
        email,
        password,
        rememberMe,
        buttonStatus,
        emailValidator,
        passwordValidator,
        isNotification,
      ];
  factory LoginState.initial() => LoginState(
        email: '',
        password: "",
        buttonStatus: ButtonStatus.idle,
        rememberMe: false,
        emailValidator: "",
        passwordValidator: "",
        isNotification: false,
      );

//<editor-fold desc="Data Methods">

  const LoginState({
    required this.email,
    required this.password,
    required this.rememberMe,
    required this.buttonStatus,
    required this.emailValidator,
    required this.passwordValidator,
    required this.isNotification,
  });

  @override
  String toString() {
    return 'LoginState{' +
        ' email: $email,' +
        ' password: $password,' +
        ' rememberMe: $rememberMe,' +
        ' buttonStatus: $buttonStatus,' +
        ' emailValidator: $emailValidator,' +
        ' passwordValidator: $passwordValidator,' +
        ' isNotification: $isNotification,' +
        '}';
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    ButtonStatus? buttonStatus,
    String? emailValidator,
    String? passwordValidator,
    bool? isNotification,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      emailValidator: emailValidator ?? this.emailValidator,
      passwordValidator: passwordValidator ?? this.passwordValidator,
      isNotification: isNotification ?? this.isNotification,
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
      'isNotification': this.isNotification,
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
      isNotification: map['isNotification'] as bool,
    );
  }

//</editor-fold>
}

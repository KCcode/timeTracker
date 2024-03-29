import 'package:time_tracker_flutter/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  final String? email;
  final String? password;
  final EmailSignInFormType? formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  EmailSignInModel copyWith(
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool isLoading,
    bool submitted,
  ) {
    return EmailSignInModel( //return expression on left unless that expression's value is null then return right
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading,
        submitted: submitted,
    );
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email!) &&
        passwordValidator.isValid(password!)
        && !isLoading;
  }

  String? get emailErrorText{
    bool showErrorText =
        submitted && !emailValidator.isValid(email!);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String? get passwordErrorText{
    bool showErrorText =
        submitted && !passwordValidator.isValid(password!);
    return showErrorText ? invalidPasswordErrorText : null;
  }
}

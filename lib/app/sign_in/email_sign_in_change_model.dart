import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/app/sign_in/validators.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
   String? email;
   String? password;
   EmailSignInFormType? formType;
   bool isLoading;
   bool submitted;
   final AuthBase auth;

  EmailSignInChangeModel({
    required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

   Future<void> submit() async {
     updateWith(
         isLoading: true,
         submitted: true);
     print('isloading: $isLoading submitted: $submitted');
     try {
       if (formType == EmailSignInFormType.signIn) {
         await auth.signInWithEmailAndPassword(email!,password!);
       } else {
         await auth.createUserWithEmailAndPassword(
             email!, password!);
       }
     } catch (e) {
       updateWith(isLoading: false, submitted: true);
       rethrow;
     }
   }

   void updateEmail(String email) => updateWith(email: email);
   void updatePassword(String password) => updateWith(password: password);

   void toggleFormType() {
     final formType = (this.formType == EmailSignInFormType.signIn)
         ? EmailSignInFormType.register
         : EmailSignInFormType.signIn;
     updateWith(
       email: '',
       password: '',
       formType: formType,
       isLoading: false,
       submitted: false,
     );
   }

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
        this.email = email ?? this.email;
        this.password = password ?? this.password;
        this.formType = formType ?? this.formType;
        this.isLoading = isLoading ?? this.isLoading;
        this.submitted = submitted ?? this.submitted;
        notifyListeners();
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

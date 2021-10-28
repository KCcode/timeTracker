import 'dart:async';

import 'package:time_tracker_flutter/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  void updateEmail(String email) => updateWith(email: email, submitted: _model.submitted);
  void updatePassword(String password) => updateWith(password: password, submitted: _model.submitted);

  void toggleFormType() {
    final formType = (_model.formType == EmailSignInFormType.signIn)
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

  void updateWith(
      { //optional named parameter
      String? email,
      String? password,
      EmailSignInFormType? formType,
      bool isLoading = false,
      bool submitted = false}) {
    _model = _model.copyWith(email, password, formType, isLoading, submitted);
    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(
        email: _model.email!,
        password: _model.password!,
        isLoading: true,
        submitted: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email!, _model.password!);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email!, _model.password!);
      }
    } catch (e) {
      updateWith(submitted: true);
      rethrow;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

import 'email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  //validators being added as mixins
  EmailSignInFormBlocBased({required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              //make column to take as much space as needed to show the card in the main axis
              children: _buildChildren(model),
            ),
          );
        });
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(model),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        model.canSubmit ? _submit : null,
        model.primaryButtonText,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(
          model.secondaryButtonText,
        ),
      ),
    ];
  }


  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      //autocorrect: false, //SDK bug
      enableSuggestions: false, //TODO also not working
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next, //enter button shows next symbol
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: (email) => widget.bloc.updateEmail(email),//rebuild widget to show that the sign in button is
    );
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done, //enter button shows done symbol
      onEditingComplete: _submit,
      onChanged: (password) => widget.bloc.updatePassword(password), //rebuild widget to show that the sign in button is enabled
    );
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop(); //pop this page
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign In Failed',
        exception: e,
      );
    }
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    //don't move from the email field when user presses enter if the email field is invalid
    final newFocus = model.emailValidator.isValid(model.email!)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context)
        .requestFocus(newFocus); //passing focusNode of the desired text field
  }

  @override
  void dispose() {
    //called when widget is removed from the widget tree
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}

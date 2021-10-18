import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/validators.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

enum EmailSignInFormType{ signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordVaidators {  //validators being added as mixins
  final AuthBase auth;

  EmailSignInForm(this.auth);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });

    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      }
      else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop(); //pop this page
    }
    catch(e){
      print(e.toString());
    }
    finally{ //always executed
      setState(() {
        _isLoading = false;
      });
    }
    //print('email: ${_emailController.text}, password: ${_passwordController.text}');
  }

  void _emailEditingComplete(){ //dont move from the email field when user presses enter if the email field is invalid
    final newFocus = widget.emailValidator.isValid(_email) ?
        _passwordFocusNode
    : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus); //passing focusnode of the desired text field
  }

  void _toggleFormType(){
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn ?
          EmailSignInFormType.register : EmailSignInFormType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn ?
        'Sign in' : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn ?
        'Need an account? Register' : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) && !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        submitEnabled ? _submit : null,
        primaryText,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(
          secondaryText,
        ),
      ),
    ];
  }

  void _updateState(){
    setState(() {
      print('email $_email, password: $_password');
    });
  }

  TextField _buildPasswordTextField() {
    bool showErrorText = _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,  //enter button shows done symbol
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),  //rebuild widget to show that the sign in button is enabled
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      //autocorrect: false, //SDK bug
      enableSuggestions: false, //TODO also not working
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next, //enter button shows next symbol
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),  //rebuild widget to show that the sign in button is enabled
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, //make column to take as much space as needed to show the card in the main axis
        children: _buildChildren(),
      ),
    );
  }
}
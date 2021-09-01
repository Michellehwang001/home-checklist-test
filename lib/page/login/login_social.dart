import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginSocial extends StatelessWidget {
  const LoginSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();

    return Scaffold(
        body: Center(
          child: Container(
            height: 50.0,
            width: 300.0,
            child: SignInButton(
              Buttons.Google,
              onPressed: () => loginViewModel.login(),
            ),
          ),
        ),
    );
  }
}

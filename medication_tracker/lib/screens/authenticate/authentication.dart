import 'package:flutter/material.dart';
import 'log_in_screen.dart';
import 'register_account_screen.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return LogInScreen(toggleView: toggleView);
    }
    else {
      return RegisterScreen(toggleView: toggleView);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/custom_widgets/email_password_button_block.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';

/// Screen that allows [User] to register a new account using an email address and password.
/// If account creation is successful [User] will automatically be logged in.
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.title, this.toggleView}) : super(key: key);

  final String title;
  final Function toggleView;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: SizedBox(
            width: 500.0,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text('Register New Account',
                    style: TextStyle(fontSize: 40.0, color: Colors.blue)),
                EmailPassBlock(
                  title: 'Register',
                  isLogInScreen: false,
                ),
                InkWell(
                  child: Text(
                    'Return to Log In',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/custom_widgets/email_password_button_block.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';


/// Log in screen where the user can enter their email address and password to access application.
class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title, this.toggleView}) : super(key: key);

  final String title;
  final Function toggleView;


  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

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
  //              Image(
  //                image: AssetImage('meds.png'),
  //                width: 3000.0,
  //                height: 100,
  //                repeat: ImageRepeat.repeat,
  //                fit: BoxFit.contain,
  //              ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.blue
                    )
                  ),
                  EmailPassBlock(
                    title: 'Sign In',
                    isLogInScreen: true,
                  ),
                  InkWell(
                    child: Text(
                        'Register New Account',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                    ),
                    onTap: () {widget.toggleView();},
                  ),
                ],
              ),
          ),
        ),
      )
    ),
    );
  }
}

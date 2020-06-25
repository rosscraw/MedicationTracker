import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/custom_widgets/email_password_button_block.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';


/// Screen that allows user to register a new account using an email address and password.
/// If account creation is successful user will automatically be logged in.
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.title, this.toggleView}) : super(key: key);

  final String title;
  final Function toggleView;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {

  final AuthService _auth = AuthService();
  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sign up'),
//        actions: <Widget>[
//          FlatButton.icon(
//              icon: Icon(
//                  Icons.person,
//                  color: Colors.white
//              ),
//              label: Text(
//                'Log In',
//                style: TextStyle(
//                    color: Colors.white
//                ),
//              ),
//              onPressed: () {
//                widget.toggleView();
//              }
//          )
//        ],
//      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                  'Register New Account',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.blue
                  )
              ),
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
                onTap: () {widget.toggleView();},
              ),
            ],
          ),
        ),
      )
    );
  }
}

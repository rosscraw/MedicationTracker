import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/custom_widgets/email_password_button_block.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title, this.toggleView}) : super(key: key);

  final String title;
  final Function toggleView;


  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  //final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
                Icons.person,
                color: Colors.white
            ),
            label: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white
                ),
            ),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: EmailPassBlock(
        title: 'Sign In',
      )
    );
  }
}

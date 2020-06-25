import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicationtracker/screens/authenticate/log_in_screen.dart';
import 'package:medicationtracker/screens/authenticate/register_account_screen.dart';
import 'package:medicationtracker/screens/custom_widgets/loading_spinner.dart';
import 'package:medicationtracker/services/firebase_authentication.dart';

/// Widget that provides an input text box for an email and password for the log in and register screens.
/// Validates input and displays any errors from unsuccessful log-in or registering attempts.
class EmailPassBlock extends StatefulWidget {

  EmailPassBlock({Key key, this.title, this.isLogInScreen}) : super(key: key);

  final String title;
  final bool isLogInScreen;


  @override
  _EmailPassBlockState createState() => _EmailPassBlockState(isLogInScreen: isLogInScreen);
}

class _EmailPassBlockState extends State<EmailPassBlock> {

  _EmailPassBlockState({this.isLogInScreen});

  final bool isLogInScreen;
  String email = '';
  String password = '';
  String error = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? LoadingSpinner() : Container (
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Image(
//            //TODO Placeholder
//              image: NetworkImage('https://www.verywellhealth.com/thmb/gtr6HGzuXimLjWeXHUZJDySlK50=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/prescription-pills-spilling-out-of-pill-bottle-close-up-200227725-001-57a46a605f9b58974a129923.jpg')
//          ),
          Form(
            key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your email address'
                        ),
                        validator: (val) => val.isEmpty ? 'Enter an email address' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your password'
                        ),
                        obscureText: true,
                        validator: (val) {
                          if (!isLogInScreen) {
                            return val.length < 6
                                ? 'Please use at least 6 characters for password'
                                : null;
                          }
                          else {
                            return val.length < 6
                                ? 'Please use at least 100 characters for password'
                                : null;
                          }
                        },
                        //validator: (value) => value.length < 6 ? 'Please use at least 6 characters for password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          widget.title.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            //Log in existing account
                            if (isLogInScreen) {
                              dynamic authResult = await _auth.signInAccount(email, password);
                              if(authResult == null) {
                                setState(() {
                                error = 'Please ensure details are valid';
                                loading = false;
                                });
                              }
                            }
                            //Register new account
                            else if (!isLogInScreen){
                              dynamic authResult = await _auth.registerAccount(email, password);
                              if(authResult == null) {
                                setState(() {
                                  error = 'Please ensure details are valid';
                                  loading = false;
                                });
                              }
                            }
                          }
                        }

                    ),
                    SizedBox(
                        height: 12.0
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}

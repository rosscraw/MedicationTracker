import 'package:flutter/material.dart';
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

  _EmailPassBlockState({@required this.isLogInScreen});

  final bool isLogInScreen;
  String _email = '';
  String _password = '';
  String _error = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? LoadingSpinner() : Container (
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[//
            Form(
              key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Enter your email address',
                          ),
                          validator: (val) => val.isEmpty ? 'Please enter an email address' : null,
                          onChanged: (val) {
                            setState(() => _email = val);
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
                                  ? 'Please ensure your password is the correct length'
                                  : null;
                            }
                          },
                          //validator: (value) => value.length < 6 ? 'Please use at least 6 characters for password' : null,
                          onChanged: (val) {
                            setState(() => _password = val);
                          }
                      ),
                      SizedBox(
                          height: 20.0
                      ),
                      Center(
                        // Error message from firebase
                        child: Text(
                          _error,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 20.0
                      ),
                      RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            widget.title.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              // Show loading spinner.
                              setState(() => _loading = true);
                              //Log in existing account
                              if (isLogInScreen) {
                                dynamic authResult = await _auth.signInAccount(_email, _password);
                                if(authResult is String) {
                                  setState(() {
                                  _error = authResult;
                                  _loading = false;
                                  });
                                }
                              }
                              //Register new account
                              else if (!isLogInScreen){
                                dynamic authResult = await _auth.registerAccount(_email, _password);
                                if(authResult == null) {
                                  setState(() {
                                    _error = 'Please ensure details are valid';
                                    _loading = false;
                                  });
                                }
                              }
                            }
                          }
                      ),
                    ]
                )
            ),
          ],
        ),
    );
  }
}

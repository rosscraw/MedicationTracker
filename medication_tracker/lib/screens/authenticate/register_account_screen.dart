import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter your email address'
                        ),
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
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(email);
                          print(password);
                        }
                    )
                  ]
              )
          )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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

                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Enter your password'
                  ),
                obscureText: true,
                onChanged: (val) {

                }
            ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                )
              )
            ]
          )
        )
      ),
    );
  }
}

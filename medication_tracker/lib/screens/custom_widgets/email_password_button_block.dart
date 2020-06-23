import 'package:flutter/material.dart';

/// Widget that provides an input text box for an email and password
class EmailPassBlock extends StatefulWidget {

  EmailPassBlock({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _EmailPassBlockState createState() => _EmailPassBlockState();
}

class _EmailPassBlockState extends State<EmailPassBlock> {

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            //TODO Placeholder
              image: NetworkImage('https://www.verywellhealth.com/thmb/gtr6HGzuXimLjWeXHUZJDySlK50=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/prescription-pills-spilling-out-of-pill-bottle-close-up-200227725-001-57a46a605f9b58974a129923.jpg')
          ),
          Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          widget.title.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(email);
                          print(password);
                        }
                    )
                  ]
              )
          ),
        ],
      ),
    );
  }
}

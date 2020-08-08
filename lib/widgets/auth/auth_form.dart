import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () {},
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Create new Account'),
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

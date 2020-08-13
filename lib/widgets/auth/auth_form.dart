import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) submitFN;

  final bool isLoading;

  AuthForm(this.submitFN, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  File _pickedImage;
  String _imagePath = "";
  final picker = ImagePicker();

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();
    //clears a focus
    //means remove the keyboard targeting perticular field

    if (isValid) {
      _formKey.currentState.save();
      //now this will triger on save
      widget.submitFN(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  void _imagePick() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = File(pickedFile.path);
      _imagePath = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: kIsWeb
                      ? _imagePath.length == 0 ? null : NetworkImage(_imagePath)
                      : _pickedImage == null ? null : FileImage(_pickedImage),
                ),
                FlatButton.icon(
                  onPressed: () => _imagePick(),
                  icon: Icon(Icons.image),
                  label: Text('Add Image'),
                ),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter valid Email Address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userEmail = newValue;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please enter username more than 4 character';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userName = newValue;
                    },
                    decoration: InputDecoration(labelText: 'User Name'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be atleast 7 Character long';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userPassword = newValue;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: _isLogin ? Text('Login') : Text('Sign Up'),
                    onPressed: () => _trySubmit(),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: _isLogin
                        ? Text('Create new Account')
                        : Text('Already have an account'),
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

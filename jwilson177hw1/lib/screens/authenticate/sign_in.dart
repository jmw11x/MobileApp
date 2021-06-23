import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:jwilson177hw1/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  // ignore: override_on_non_overriding_member
  final Function toggleView;
  SignIn({required this.toggleView});
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String role = '';
  String first = '';
  String last = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign in to see Jacob now!'),
        actions: <Widget>[
          Container(
            color: Colors.lightGreenAccent,
            child: TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('New User'),
              onPressed: () => widget.toggleView(),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (v) => v!.isEmpty ? 'cannot leave empty' : null,
                decoration: InputDecoration(
                    hintText: 'Email', helperText: 'Please enter your email'),
                onChanged: (v) => {setState(() => email = v)},
              ),
              TextFormField(
                validator: (v) => v!.isEmpty ? 'cannot leave empty' : null,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'password',
                    helperText: 'Please enter your password'),
                onChanged: (v) => {setState(() => password = v)},
              ),
              ElevatedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic res = await _auth.signinWithEmailAndPassword(
                          email, password);
                      res == null ? print("error") : print("success");
                    } else {
                      print("fail");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

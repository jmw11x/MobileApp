// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jwilson177hw1/models/user.dart';
import 'package:jwilson177hw1/services/adminalert.dart';
import 'package:jwilson177hw1/services/auth.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  AdminAlert db = new AdminAlert();
  @override
  Widget build(BuildContext context) {
    Future<String> msgs = db.getMessagesAsString();
    String msg;
    msgs.then((value) => setState(() {
          msg = value;
        }));
    print(msg);
    return Scaffold(
        appBar: AppBar(
          title: Text("Jacobs hw1"),
          backgroundColor: Colors.greenAccent,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Text(msg),
        ));
  }
}

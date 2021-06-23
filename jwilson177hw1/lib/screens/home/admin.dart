import 'package:flutter/material.dart';
import 'package:jwilson177hw1/services/adminalert.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:jwilson177hw1/services/auth.dart';

class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String message = '';
  String msg = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingControler =
              TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      controller: _textEditingControler,
                      validator: (value) {
                        value!.isNotEmpty ? null : "invalid message";
                      },
                      decoration: InputDecoration(hintText: "Enter message"),
                      onChanged: (v) => {setState(() => message = v)})
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('submin'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    AdminAlert db = new AdminAlert();
    Future<String> msgs = db.getMessagesAsString();

    msgs.then((value) => setState(() {
          msg = value;
        }));

    return Scaffold(
        appBar: AppBar(
          title: Text("Jacobs hw1 Admin"),
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
        body: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: ElevatedButton(
                  child: Text('+'),
                  onPressed: () async {
                    await showInformationDialog(context);
                    db.addAdminMessage(message);
                  }),
            ),
            SingleChildScrollView(
              child: Text(msg),
            )
          ],
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwilson177hw1/models/user.dart';

class Database {
  //collection reference
  final String uid;
  Database({required this.uid});
  var role = 'customer';
  final CollectionReference user_refs = Firestore.instance.collection('users');

  Future<String> isAdmin() async {
    DocumentSnapshot ds = await user_refs.document(uid).get();
    return ds.data['role'];
  }

  final CollectionReference message_refs =
      Firestore.instance.collection('messages');

  // Future getMessages() async{
  //   var snapshot = FirebaseFirestore.instance
  //         .collection('messagee')
  //         .orderBy('createdAt', descending: true)
  //         .snapshots();
  // }

  Future addUserData(String first, String last, String role) async {
    await user_refs.document(uid).setData({
      'firstName': first,
      'lastName': last,
      'role': role,
    });
  }
}

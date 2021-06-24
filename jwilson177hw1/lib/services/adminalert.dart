// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAlert {
  final CollectionReference messages =
      Firestore.instance.collection('messages');

  Future<String> getMessagesAsString() async {
    String msgs = '';
    await messages.getDocuments().then((message) {
      message.documents.forEach((value) {
        if (value['message'] != null) {
          // print();

          msgs = msgs + (value['message']) + "\n";
        }
      });
    });
    // print('below');
    // print(msgs);

    return msgs;
  }

  Future addAdminMessage(String message) async {
    await messages.document().setData({
      'message': message,
      'datetime': DateTime.now().toString(),
    });
  }
}

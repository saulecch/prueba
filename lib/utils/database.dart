import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  static Future<void> updateItem({
    // ignore: non_constant_identifier_names
    required String full_name,
    required String company,
    required String age,
    required String docId,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "full_name": full_name,
      "company": company,
      "age": age,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print('El usuario se actualizó'))
        .catchError((error) => print(error));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}

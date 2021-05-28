import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  final _firebaseStorage = FirebaseStorage.instance;

  Future deleteUserData() async {
    await _firebaseStorage.ref(uid).delete();
    return userCollection.doc(uid).delete();
  }
}

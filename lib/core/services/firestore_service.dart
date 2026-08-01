import 'package:cloud_firestore/cloud_firestore.dart';

/// Thin generic wrapper around Firestore so repositories don't repeat
/// boilerplate. Repositories still own their own typed query logic.
class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return db.collection(path);
  }

  Future<DocumentReference<Map<String, dynamic>>> add(
    String collectionPath,
    Map<String, dynamic> data,
  ) {
    return collection(collectionPath).add(data);
  }

  Future<void> set(
    String collectionPath,
    String docId,
    Map<String, dynamic> data, {
    bool merge = true,
  }) {
    return collection(collectionPath)
        .doc(docId)
        .set(data, SetOptions(merge: merge));
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getById(
    String collectionPath,
    String docId,
  ) {
    return collection(collectionPath).doc(docId).get();
  }

  Future<void> update(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) {
    return collection(collectionPath).doc(docId).update(data);
  }

  Future<void> delete(String collectionPath, String docId) {
    return collection(collectionPath).doc(docId).delete();
  }
}

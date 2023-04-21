import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_constant.dart';

class FirestoreHelper {
  static FirestoreHelper? _instance;
  FirestoreHelper._();
  static FirestoreHelper get instance {
    return _instance ?? (_instance = FirestoreHelper._());
  }

  Future<void> addData(
      String collectionPathName, String id, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collectionPathName)
        .doc(id)
        .set(data);
  }

  Future<void> updateData(
      String collectionPathName, String id, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collectionPathName)
        .doc(id)
        .update(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData(
      String collectionPathName, String id) async {
    return await FirebaseFirestore.instance
        .collection(collectionPathName)
        .doc(id)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> findWeatherDataById(
      String id) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseConstant.collectionWeatherName)
        .where(FirebaseConstant.id, isEqualTo: id)
        .get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnouncementDao {
  static getAnouncements() async {
    var batchsInstance = await FirebaseFirestore.instance
        .collection('users')
        .doc(globalStudent.tId)
        .collection('Batches')
        .get();
    dynamic batch;
    for (var e in batchsInstance.docs) {
      if (e.data()['name'] == globalStudent.batch) {
        batch = e;
      }
    }
    if (batch == null) return Future.value(batch!.data()['batchMessageArray']);
  }
}

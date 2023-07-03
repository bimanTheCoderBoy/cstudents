import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Validator {
  //number validation
  static numberIsValid(String mobileNum) {
    if (mobileNum.length == 10 &&
        ((mobileNum[0] == '9' ||
            mobileNum[0] == '8' ||
            mobileNum[0] == '7' ||
            mobileNum[0] == '6'))) {
      return true;
    } else {
      return false;
    }
  }

  static tIdIsValid(String tId) async {
    var teacher = await FirebaseFirestore.instance
        .collection('users')
        .doc(tId == "" ? "4254" : tId)
        .get();

    return teacher.exists
        ? await Future.value(true)
        : await Future.value(false);
  }

  static batchIsValid(String batch, String tId) async {
    bool res = false;

    var batchInstance = await FirebaseFirestore.instance
        .collection('users')
        .doc(tId)
        .collection('Batches')
        .get()
        .then((value) => value.docs.map((e) => e.data()['name']).toList())
        .then((value) => value.contains(batch));

    return batchInstance;
  }

  static passwordIsValid(String password) {
    return password.length >= 4;
  }

  static emailIsValid(String email) {
    return email.contains("@");
  }
}

import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../dao/studentDao.dart';
import '../entity/StudentEntity.dart';
import '../pages/home/Home.dart';

class StudentService {
  static double getPerformance() {
    num gotmarks = 0;
    num totalMarks = 0;
    if (globalStudent.studentExamArray == null) return 75;
    for (dynamic e in globalStudent.studentExamArray!) {
      gotmarks = gotmarks + e['yourMarks'];
      totalMarks = totalMarks + e['totalMarks'];
    }
    return (gotmarks / totalMarks) * 100.0;
  }

  static List getUnpaidArray() {
    List accountArray = globalStudent.account ?? [];
    accountArray = accountArray.takeWhile((value) => value['isPaid']).toList();
    accountArray = accountArray.reversed.toList();
    print(accountArray);
    return accountArray;
  }

  static makeCall() async {
    await FlutterPhoneDirectCaller.callNumber("6297372813");
  }

  static sendSms(TextEditingController _smsControllar) async {
    Future<bool> check;
    check = Future.value(true);
    try {
      var res = await BackgroundSms.sendMessage(
          simSlot: 1,
          phoneNumber: "6297372813",
          message: _smsControllar.text.trim());
      debugPrint(res.name.toString());
    } catch (e) {
      debugPrint(e.toString());
      check = Future.value(false);
    }
    if (await check) {
      Fluttertoast.showToast(
          msg: "message sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(88, 3, 158, 18),
          textColor: Color.fromARGB(255, 238, 238, 238),
          fontSize: 14.0);
    } else {
      Fluttertoast.showToast(
          msg: "Failed sending",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(69, 186, 0, 0),
          textColor: Color.fromARGB(255, 240, 240, 240),
          fontSize: 14.0);
    }
    return check;
  }
}

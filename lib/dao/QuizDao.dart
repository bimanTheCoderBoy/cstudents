import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cstudents/entity/Quiz.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

readQuizes() async {
  String? tid = globalStudent.tId;
  String? stBatch = globalStudent.batch;
  var allDatabaseQuizes = [];
  List<Quiz> allQuizes = [];
  if (tid == null || stBatch == null) {
    return false;
  }
  if (tid != null) {
    allDatabaseQuizes = await FirebaseFirestore.instance
        .collection('users')
        .doc(tid)
        .get()
        .then((value) => value.data()!['teacherQuizArray']);
  }

  //making database to dart object
  allQuizes = allDatabaseQuizes.map((e) => Quiz.fromJson(e)).toList();

  //filtering quizes on basis of batch
  if (stBatch != null) {
    allQuizes = allQuizes.where((e) => e.batches!.contains(stBatch)).toList();
  }

  //setting quizes (given or not)
  var user = FirebaseAuth.instance.currentUser;
  var stQuizArray = await FirebaseFirestore.instance
      .collection('users')
      .doc(tid)
      .collection('student')
      .doc(user!.uid)
      .get()
      .then((value) => value.data()!['studentQuizArray']);
  if (stQuizArray != null) {
    for (var element in stQuizArray) {
      for (var e in allQuizes) {
        if (e.id == element['id']) {
          e.isGivenAlready = true;
        }
      }
    }
  }

  return allQuizes;
}

evaluateQuiz() {}

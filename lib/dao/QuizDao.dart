import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cstudents/entity/Quiz.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

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
  var stQuizDataBase = await FirebaseFirestore.instance
      .collection('users')
      .doc(tid)
      .collection('student')
      .doc(user!.uid)
      .get()
      .then((value) => value.data()!['studentQuizArray']);

  if (stQuizDataBase != null) {
    var stQuizMap = Map.castFrom(jsonDecode(stQuizDataBase));
    stQuizMap.forEach((key, value) {
      for (var e in allQuizes) {
        if (e.id == key) {
          e.isGivenAlready = true;
        }
      }
    });
  }

  return allQuizes;
}

updateQuizResults(int score, Quiz quiz) async {
  //teacher updation
  String? tid = globalStudent.tId;
/*
  var allDatabaseQuizes = [];
  List<Quiz> allQuizes = [];
  if (tid == null) {
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
  allQuizes.remove(quiz);
  quiz.results.add({
    "studentName": globalStudent.name,
    "studentBatch": globalStudent.batch,
    "studentScore": score
  });
  allQuizes.add(quiz);
  //put in database
  await FirebaseFirestore.instance
      .collection('users')
      .doc(tid)
      .update({'teacherQuizArray': allQuizes});

//end
*/
// student updation
  var user = FirebaseAuth.instance.currentUser;

  Map<String, int> stQuizMap = {};
  try {
    var stQuizDatabase = await FirebaseFirestore.instance
        .collection('users')
        .doc(tid)
        .collection('student')
        .doc(user!.uid)
        .get()
        .then((value) => value.data()!['studentQuizArray']);
    if (stQuizDatabase != null) {
      stQuizMap = Map.castFrom(jsonDecode(stQuizDatabase));
    }

    stQuizMap[quiz.id as String] = score;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(tid)
        .collection('student')
        .doc(user!.uid)
        .update({'studentQuizArray': jsonEncode(stQuizMap)});
  } catch (e) {}

  //end
}

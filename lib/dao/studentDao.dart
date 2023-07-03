import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../entity/StudentEntity.dart';

class StudentDao {
  static final user = FirebaseAuth.instance.currentUser;
  static var tId = "";
  static Future getTid() async {
    var studentInstance = await FirebaseFirestore.instance
        .collection('studentUsers')
        .doc(user!.uid)
        .get();

    tId = studentInstance.data()?['tid'];
    return Future.value(studentInstance.data()?['tid']);
  }

  static Future getSclass(String batchName) async {
    var batchesInstance = await FirebaseFirestore.instance
        .collection('users')
        .doc(tId)
        .collection('Batches')
        .get();
    var sClass = "NA";
    for (var batch in batchesInstance.docs) {
      if (batch.data()['name'] == batchName) {
        sClass = batch.data()['class'];
      }
    }

    return Future.value(sClass);
  }

  //getting Student Entity
  static Future<StudentEntity> getStudentEntity() async {
    await getTid();

    var entityInstance = await FirebaseFirestore.instance
        .collection('users')
        .doc(tId)
        .collection('student')
        .doc(user!.uid)
        .get();

    StudentEntity entity = StudentEntity.fromJson(entityInstance.data());
    var batchName = entity.batch;

    entity.sclass = await getSclass(batchName ?? "");
    entity.tId = tId;
    print(entity.name);
    return Future.value(entity);
  }
}

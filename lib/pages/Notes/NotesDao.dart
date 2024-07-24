import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NoteCumFolder {
  dynamic data;
  bool isNote = false;
  NoteCumFolder(this.data, this.isNote);
}

getAllNotesAndFolder(String path) async {
  ListResult result = await FirebaseStorage.instance.ref(path).listAll();
  List<NoteCumFolder> refList = [];

  //taking all folder
  result.prefixes.forEach((Reference ref) {
    print(ref.name);
    refList.add(NoteCumFolder(ref, false));
  });
  //taking all files
  result.items.forEach((Reference ref) {
    if (ref.fullPath.endsWith("pdf")) {
      refList.add(NoteCumFolder(ref, true));
    }
    print(ref.name);
  });

  return refList;
}

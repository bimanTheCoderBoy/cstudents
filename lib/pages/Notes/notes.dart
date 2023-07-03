// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../service/studentService.dart';
import '../../util/colors.dart';
import 'openPdf.dart';

class Notes extends StatefulWidget {
  var path;
  Notes({super.key, required this.path});

  @override
  // ignore: no_logic_in_create_state
  State<Notes> createState() => _NotesState(path: path);
}

class _NotesState extends State<Notes> {
  _NotesState({this.path});
  @override
  var path;
  List refList = [];
  bool loading = true;
  bool isDispose = false;
  var _smsControllar = TextEditingController();

  @override
  void dispose() {
    // ignore: avoid_print
    isDispose = true;

    super.dispose();
  }

  //---------------------> this is for the on tap open openPdf File giving this File the File element
  Future<File?> loadFirebase(String url, BuildContext context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: Component.loading);
        }));
    try {
      final refPDF = FirebaseStorage.instance.ref("$path/$url");
      final bytes = await refPDF.getData();

      return _storeFile("$path/$url", bytes!, context);
    } catch (e) {
      return null;
    }
  }

  //Store file into the storage show that it can show
  Future<File> _storeFile(
      String url, List<int> bytes, BuildContext context) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    Navigator.pop(context);
    return file;
  }

  // onClick giving this file the file Element
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
  //-----------------------------------------> openPdf Work END

  //getting all the pdfs in the class are available
  listAll() async {
    ListResult result = await FirebaseStorage.instance.ref(path).listAll();
    refList.clear();
    for (var ref in result.items) {
      refList.add(ref);
    }
    if (!isDispose) {
      setState(() {
        refList = refList;
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // FirebaseAuth.instance.signOut();
    listAll();
    super.initState();
  }

  showSmsBox(BuildContext context) {
    return showGeneralDialog(
        context: context,
        transitionBuilder: (context, a1, a2, widget) => Transform.scale(
            scale: a1.value,
            child: StatefulBuilder(
              builder: (context, setStateSB) => Dialog(
                  backgroundColor: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  insetPadding: EdgeInsets.all(10),
                  child: Container(
                    alignment: Alignment.center,
                    color: Color.fromARGB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 249, 249, 249)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topRight,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Message",
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _smsControllar,
                                  minLines: 10,
                                  maxLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(14, 0, 0, 0),
                                      label: const Text(
                                        "Share your chemistry problems",
                                        style: TextStyle(
                                            color: Color.fromARGB(96, 0, 0, 0)),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  182, 73, 134, 255),
                                              width: 2)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  182, 46, 53, 248),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            backgroundColor: AppColors.appBar),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _smsControllar.clear();
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 45,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              "Close",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      218, 255, 255, 255)),
                                            ))),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            backgroundColor: AppColors.appBar),
                                        onPressed: () async {
                                          await StudentService.sendSms(
                                              _smsControllar);
                                          _smsControllar.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 45,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              "Send",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ))),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                              top: -10,
                              right: -15,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _smsControllar.clear();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Color.fromARGB(255, 100, 100, 100),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            )),
        transitionDuration: Duration(milliseconds: 150),
        barrierLabel: '',
        pageBuilder: (context, animation1, animation2) {
          return Text("page builder");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2,
          backgroundColor: AppColors.appBar,
          title: Text(
            "Notes",
            style: GoogleFonts.lato(fontSize: 20),
          ),
          leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
          actions: [
            TextButton(
                onPressed: () async {
                  await StudentService.makeCall();
                },
                child: const Icon(
                  Icons.call,
                  color: Colors.white,
                )),
            TextButton(
                onPressed: () {
                  showSmsBox(context);
                },
                child: const Icon(
                  Icons.sms,
                  color: Colors.white,
                )),
          ],
        ),
        body: Container(
          color: AppColors.bgBlue,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appBar,
                  ),
                )
              : refList.isEmpty
                  ? const Center(
                      child: Text("No Results Found"),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: refList.length,
                        itemBuilder: (context, index) {
                          String name = "${refList[index].name}";
                          name = name.substring(0, name.length - 4);
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                height: 60,
                                width: MediaQuery.of(context).size.width - 16,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              132, 195, 195, 195),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ]),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  width: MediaQuery.of(context).size.width - 36,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.asset(
                                        'assets/images/pdfIcon.png',
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                name,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color: AppColors.appBar),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -0.2,
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(0)),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColors.splashColor!),
                                  ),
                                  onPressed: () async {
                                    File? file = await loadFirebase(
                                        "${refList[index].name}", context);
                                    if (file != null) {
                                      openPDF(context, file);
                                    }
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(bottom: 8),
                                    height: 61,
                                    width:
                                        MediaQuery.of(context).size.width - 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                            begin: (index % 2 == 0 ||
                                                    index % 2 == 1)
                                                ? Alignment.topRight
                                                : Alignment.bottomLeft,
                                            end: (index % 2 == 0 ||
                                                    index % 2 == 1)
                                                ? Alignment.bottomLeft
                                                : Alignment.topRight,
                                            colors: const [
                                              Color.fromARGB(47, 49, 61, 190),
                                              Color.fromARGB(
                                                  255, 232, 228, 251),
                                              Color.fromARGB(0, 252, 254, 255)
                                            ]),
                                      ),
                                      gradient: LinearGradient(
                                          begin:
                                              (index % 2 == 0 || index % 2 == 1)
                                                  ? Alignment.topRight
                                                  : Alignment.bottomLeft,
                                          end:
                                              (index % 2 == 0 || index % 2 == 1)
                                                  ? Alignment.bottomLeft
                                                  : Alignment.topRight,
                                          colors: const [
                                            Color.fromARGB(44, 14, 29, 197),
                                            Color.fromARGB(15, 14, 29, 197),
                                            // Color.fromARGB(255, 232, 228, 251),
                                            Color.fromARGB(0, 255, 255, 255)
                                          ]),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
        ));
  }
}

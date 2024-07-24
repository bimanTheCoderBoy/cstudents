// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../service/studentService.dart';
import '../../util/colors.dart';
import 'NotesDao.dart';
import 'openPdf.dart';

class Notes extends StatefulWidget {
  String url;
  Notes(this.url, {super.key});

  @override
  State<Notes> createState() => _NotesState(url);
}

class _NotesState extends State<Notes> {
  String url;
  var _smsControllar = TextEditingController();
  List<NoteCumFolder>? refList;

  _NotesState(this.url);
  load() async {
    print(url);
    refList = await getAllNotesAndFolder(url);
    refList ??= [];
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    checkLocal(String path) async {
      final filename = basename(path);
      final dir = await getApplicationDocumentsDirectory();
      File? file;
      try {
        file = File('${dir.path}/$filename');
      } catch (e) {
        file = null;
      }

      return await (file!.exists()) ? file : null;
    }

//open pdf pdf loading
    Future<File> _storeFile(
        String url, List<int> bytes, BuildContext context) async {
      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      Navigator.pop(context);
      return file;
    }

    Future<File?> loadFirebase(String url, BuildContext context) async {
      showDialog(
          context: context,
          builder: ((context) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Loading PDF from Database..",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            );
          }));
      try {
        final refPDF = FirebaseStorage.instance.ref("${url}");
        final bytes = await refPDF.getData();

        return _storeFile("$url", bytes!, context);
      } catch (e) {
        return null;
      }
    }

    void openPDF(BuildContext context, File file) => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
        );
//sms
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
                                        floatingLabelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                182, 46, 53, 248)),
                                        labelStyle:TextStyle(
                                            color: Color.fromARGB(
                                                96, 0, 0, 0)) ,
                                        filled: true,
                                        fillColor:
                                            const Color.fromARGB(14, 0, 0, 0),
                                        labelText:
                                            "Share your chemistry problems",
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              backgroundColor:
                                                  AppColors.appBar),
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
                                                      BorderRadius.circular(
                                                          20)),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              backgroundColor:
                                                  AppColors.appBar),
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
                                                      BorderRadius.circular(
                                                          20)),
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
    //sms end

    return Scaffold(
        backgroundColor: AppColors.bodywhite,
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
        body: refList == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : refList!.isEmpty
                ? Center(
                    child: Text("No Data Found"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 15),
                    itemCount: refList!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            // height: 60,
                            constraints: BoxConstraints(minHeight: 60),
                            width: MediaQuery.of(context).size.width - 16,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(132, 195, 195, 195),
                                      blurRadius: 10,
                                      spreadRadius: 1)
                                ]),
                            child: Container(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              width: MediaQuery.of(context).size.width - 36,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  (refList![index].isNote)
                                      ? Image.asset(
                                          'assets/images/pdfIcon.png',
                                          height: 30,
                                        )
                                      : Image.asset(
                                          'assets/images/folderimg.png',
                                          height: 23,
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 5),
                                        child: Text(
                                          refList![index].data.name,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: AppColors.appBar),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -0.2,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(0)),
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => AppColors.splashColor!),
                              ),
                              onPressed: () async {
                                if (refList![index].isNote) {
                                  var file = await checkLocal(
                                      refList![index].data.fullPath);
                                  if (file == null) {
                                    file = await loadFirebase(
                                        refList![index].data.fullPath, context);
                                  }

                                  if (file != null) {
                                    openPDF(context, file);
                                  }
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          Notes(refList![index].data.fullPath),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                // margin: EdgeInsets.only(bottom: 8),
                                // height: 61,
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                constraints: BoxConstraints(minHeight: 60),
                                width: MediaQuery.of(context).size.width - 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                        begin:
                                            (index % 2 == 0 || index % 2 == 1)
                                                ? Alignment.topRight
                                                : Alignment.bottomLeft,
                                        end: (index % 2 == 0 || index % 2 == 1)
                                            ? Alignment.bottomLeft
                                            : Alignment.topRight,
                                        colors: const [
                                          Color.fromARGB(47, 49, 61, 190),
                                          Color.fromARGB(255, 232, 228, 251),
                                          Color.fromARGB(0, 252, 254, 255)
                                        ]),
                                  ),
                                  gradient: LinearGradient(
                                      begin: (index % 2 == 0 || index % 2 == 1)
                                          ? Alignment.topRight
                                          : Alignment.bottomLeft,
                                      end: (index % 2 == 0 || index % 2 == 1)
                                          ? Alignment.bottomLeft
                                          : Alignment.topRight,
                                      colors: const [
                                        Color.fromARGB(44, 14, 29, 197),
                                        Color.fromARGB(15, 14, 29, 197),
                                        // Color.fromARGB(255, 232, 228, 251),
                                        Color.fromARGB(0, 255, 255, 255)
                                      ]),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 7),
                                  child: Text(
                                    refList![index].data.name,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ));
  }
}

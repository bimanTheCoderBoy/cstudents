import 'package:cstudents/dao/anouncementsDao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/studentService.dart';
import '../../util/colors.dart';

class Anouncement extends StatefulWidget {
  const Anouncement({super.key});

  @override
  State<Anouncement> createState() => _AnouncementState();
}

class _AnouncementState extends State<Anouncement> {
  dynamic anouncementArray;
  bool loading = true;
  bool isDispose = false;
  var _smsControllar = TextEditingController();

  loadAnouncementArray() async {
    anouncementArray = await AnouncementDao.getAnouncements();

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  showSmsBox() {
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
  void dispose() {
    // ignore: avoid_print
    isDispose = true;
    super.dispose();
  }

  @override
  void initState() {
    loadAnouncementArray();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2,
          backgroundColor: AppColors.appBar,
          title: Text(
            "News",
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
                  showSmsBox();
                },
                child: const Icon(
                  Icons.sms,
                  color: Colors.white,
                )),
          ],
        ),
        body: Container(
          color: AppColors.bgBlue,
          child: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appBar,
                  ),
                )
              : anouncementArray == null
                  ? Center(
                      child: Text("No result Found"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: anouncementArray.length,
                      itemBuilder: (context, index) {
                        return Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(minHeight: 80),
                                margin: const EdgeInsets.only(
                                    bottom: 13, left: 5, right: 5),
                                // padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: (index % 2 == 0)
                                            ? Alignment.topRight
                                            : Alignment.bottomLeft,
                                        end: (index % 2 == 0)
                                            ? Alignment.bottomLeft
                                            : Alignment.topRight,
                                        colors: const [
                                          Color.fromARGB(255, 215, 218, 250),
                                          Color.fromARGB(255, 232, 228, 251),
                                          Color.fromARGB(255, 252, 254, 255)
                                        ]),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              172, 180, 180, 180),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 4, right: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${anouncementArray[index]['time']}",
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 149, 149, 149),
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 7),
                                      child: Text(
                                        "${anouncementArray[index]['message']}                   .",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 76, 76, 76)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 15,
                                  right: 10,
                                  child: Text(
                                    "${anouncementArray[index]['date']}"
                                                .length ==
                                            4
                                        ? "${anouncementArray[index]['date']}"
                                        : "${anouncementArray[index]['date']}",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 153, 153, 153),
                                        fontSize: 12),
                                  )),
                              const Positioned(
                                  top: -11.5,
                                  left: 2,
                                  child: Icon(
                                    Icons.volume_up,
                                    color: Color.fromARGB(255, 77, 97, 160),
                                  ))
                            ]);
                      },
                    ),
        ));
  }
}

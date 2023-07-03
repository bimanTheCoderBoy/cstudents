import 'package:cstudents/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../service/studentService.dart';
import '../../util/colors.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  bool loading = true;
  List resultArray = [];
  bool isDispose = false;
  var _smsControllar = TextEditingController();
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
    super.initState();
    getresultArray();
  }

  getresultArray() async {
    if (globalStudent.studentExamArray == null) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          resultArray = [];
        });
      });
    } else {
      setState(() {
        resultArray = globalStudent.studentExamArray!;
      });
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2,
          backgroundColor: AppColors.appBar,
          title: Text(
            "Exam Results",
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
        body: loading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.appBar),
              )
            : resultArray.isEmpty
                ? const Center(
                    child: Text("No Results Found"),
                  )
                : Container(
                    color: AppColors.bgBlue,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: resultArray.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient: LinearGradient(
                                      begin: (index % 2 == 0)
                                          ? Alignment.topRight
                                          : Alignment.bottomLeft,
                                      end: (index % 2 == 0)
                                          ? Alignment.bottomLeft
                                          : Alignment.topRight,
                                      colors: const [
                                        Color.fromARGB(128, 49, 61, 190),
                                        Color.fromARGB(255, 232, 228, 251),
                                        Color.fromARGB(255, 252, 254, 255)
                                      ]),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                    begin: (index % 2 == 0)
                                        ? Alignment.topRight
                                        : Alignment.bottomLeft,
                                    end: (index % 2 == 0)
                                        ? Alignment.bottomLeft
                                        : Alignment.topRight,
                                    colors: const [
                                      Color.fromARGB(255, 207, 211, 251),
                                      Color.fromARGB(255, 232, 228, 251),
                                      Color.fromARGB(255, 252, 254, 255)
                                    ]),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 207, 211, 251),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(-2, -1)),
                                  BoxShadow(
                                      color: Color.fromARGB(255, 227, 219, 208),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(2, 1))
                                ]),
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 8, right: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 15),
                                      child: CircularPercentIndicator(
                                        animation: true,
                                        animationDuration: 2000,
                                        radius: 90,
                                        lineWidth: 7,
                                        percent: resultArray[index]
                                                ['yourMarks'] /
                                            resultArray[index]['totalMarks'],
                                        progressColor: Colors.green,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        backgroundColor: const Color.fromARGB(
                                            105, 160, 1, 1),
                                        center: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5000),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 207, 211, 251),
                                                    spreadRadius: 1,
                                                    blurRadius: 5)
                                              ]),
                                          child: Center(
                                            child: Text(
                                              "${resultArray[index]['yourMarks']}",
                                              style: GoogleFonts.lato(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 60),
                                      child: Text(
                                        "${resultArray[index]['totalMarks']}",
                                        style: GoogleFonts.lato(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.appBar),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 15),
                                      child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              color: AppColors.appBar,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: const Icon(
                                            Icons.class_,
                                            color: Colors.white,
                                            size: 16,
                                          )),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 10, bottom: 15),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "${resultArray[index]['examName']} Obtaining ",
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appBar),
                                        ),
                                      ),
                                    )),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 5, bottom: 5, left: 4, top: 3),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 166, 166, 166),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(5))),
                                      child: Text(
                                        "${resultArray[index]['date']}",
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 224, 224, 224)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ));
                      },
                    ),
                  ));
  }
}

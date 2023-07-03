// ignore: file_names
// ignore_for_file: deprecated_member_use
/*
import 'dart:ui';

import 'package:cstudents/pages/home/Home.dart';
import 'package:cstudents/util/animations/rotate.dart';
import 'package:cstudents/util/animations/tilt.dart';
import 'package:cstudents/util/animations/tilt_plus_rotate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/studentService.dart';
import '../../service/upi.dart';
import '../../util/colors.dart';
import 'dart:math';

class MainPaymentPage extends StatefulWidget {
  const MainPaymentPage({super.key});

  @override
  State<MainPaymentPage> createState() => _MainPaymentPageState();
}

class _MainPaymentPageState extends State<MainPaymentPage>
    with TickerProviderStateMixin {
  List unPaidArray = [];
  num money = 0;
  num monthCounter = 0;
  num maxMonthCounter = 0;
  bool isDispose = false;
  List counterMonth = [];
  var _smsControllar = TextEditingController();

  stateSetter() {
    if (!isDispose) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unPaidArray = StudentService.getUnpaidArray();
    maxMonthCounter = unPaidArray.length;

    stateSetter();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // primary: false,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: AppColors.appBar,
          title: Text(
            "Payment",
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
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            // alignment: Alignment.center,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.appBar,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: TiltPlusRotate(
                        front: FrontWidget(),
                        back: BackWidget(),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50, top: 30),
                  height: 230,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 244, 244),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromARGB(136, 197, 197, 197),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(16, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 20,
                            offset: Offset(0, 5)),
                      ]),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "$money",
                                        style: GoogleFonts.shanti(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 73, 73, 73)),
                                      ),
                                    )),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0)),
                                    onPressed: () {
                                      if (monthCounter > 0) {
                                        monthCounter -= 1;
                                        if (unPaidArray.length > monthCounter) {
                                          money -=
                                              unPaidArray[monthCounter as int]
                                                  ['dueMoney'];
                                          counterMonth.removeLast();
                                        }
                                      }

                                      stateSetter();
                                    },
                                    child: Icon(Icons.remove)),
                                Text("$monthCounter"),
                                TextButton(
                                    onPressed: () {
                                      if (monthCounter < maxMonthCounter) {
                                        if (unPaidArray.length > monthCounter) {
                                          money +=
                                              unPaidArray[monthCounter as int]
                                                  ['dueMoney'];
                                          counterMonth.add(
                                              unPaidArray[monthCounter as int]);
                                        }
                                        monthCounter += 1;
                                      }

                                      stateSetter();
                                    },
                                    child: Icon(Icons.add))
                              ],
                            ),
                          ),
                          const Positioned(
                              top: 15,
                              left: 5,
                              child: Icon(
                                Icons.currency_rupee,
                                color: Color.fromARGB(255, 129, 129, 129),
                                size: 27,
                              ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        // decoration: BoxDecoration(color: Colors.black12),
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: counterMonth.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(81, 0, 15, 182),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color.fromARGB(90, 170, 0, 182),
                                        width: .6)),
                                // alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 8),
                                height: 50,
                                width: 100,
                                // color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${counterMonth[index]['month']}",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("${counterMonth[index]['year']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ));
                          },
                        ),
                      ),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            "assets/images/phonepe.png",
                            height: 50,
                          ),
                          Image.asset(
                            "assets/images/gpay.png",
                            height: 50,
                          ),
                          Image.asset(
                            "assets/images/upi.png",
                            height: 30,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: AppColors.appBar,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width - 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Pay ",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text("(Not available now)",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(119, 255, 255, 255))),
                        ],
                      ),
                    ))
              ],
            )));
  }
}

class FrontWidget extends StatelessWidget {
  const FrontWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 325,
          height: 200,
          // width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    // Color.fromARGB(255, 44, 61, 191),
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(1),
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.3),
                    // Colors.white.withOpacity(0.2),
                  ]),
              borderRadius: BorderRadius.circular(12),
              border: const GradientBoxBorder(
                width: .6,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      // Color.fromARGB(255, 27, 45, 176),
                      // Color.fromARGB(255, 27, 45, 176),
                      // Color.fromARGB(146, 16, 0, 89),
                      // Color.fromARGB(146, 16, 0, 89),
                      // Color.fromARGB(146, 27, 15, 83),
                      // Color.fromARGB(146, 56, 43, 114),
                      // Color.fromARGB(109, 128, 115, 187),
                      // Color.fromARGB(108, 199, 191, 238),
                      // Color.fromARGB(108, 199, 191, 238),

                      // Color.fromARGB(52, 255, 255, 255),
                      // Color.fromARGB(52, 255, 255, 255),
                      // Color.fromARGB(65, 0, 0, 0),
                      // Color.fromARGB(52, 0, 0, 0),
                      // Color.fromARGB(52, 0, 0, 0),
                      Color.fromARGB(52, 255, 255, 255),
                      Color.fromARGB(65, 255, 255, 255),
                      // Color.fromARGB(52, 255, 255, 255),
                      // Color.fromARGB(52, 255, 255, 255),
                    ]),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 0)),
              ]),
        ),
        Positioned(
            top: 10,
            left: 15,
            child: Image.asset(
              "assets/images/chip.png",
              height: 45,
            )),
        Positioned(
            top: 10,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text("Chemia Card",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(119, 255, 255, 255))),
            )),
        Positioned(
          top: 100,
          left: 85,
          child: Text("Not available now",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(119, 255, 255, 255))),
        )
      ],
    );
  }
}

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: 325,
            height: 200,
            // width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      // Color.fromARGB(255, 44, 61, 191),

                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(1),
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.5),

                      // Colors.white.withOpacity(0.2),
                    ]),
                borderRadius: BorderRadius.circular(12),
                border: const GradientBoxBorder(
                  width: .6,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(52, 255, 255, 255),
                        Color.fromARGB(65, 255, 255, 255),
                      ]),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 20,
                      offset: Offset(0, 0)),
                ])),
        const Positioned(
          top: 65,
          left: 110,
          child: Icon(
            Icons.currency_rupee,
            color: Color.fromARGB(178, 150, 0, 0),
            // color: Color.fromARGB(255, 70, 70, 70),
            size: 45,
          ),
        ),
        Positioned(
          left: 145,
          child: Text(
            "${globalStudent.balance}",
            style: GoogleFonts.roboto(
                fontSize: 30,
                // color: AppColors.appBar,
                color: Color.fromARGB(191, 7, 1, 128),
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
*/
import 'package:background_sms/background_sms.dart';
import 'package:cstudents/dao/studentDao.dart';
import 'package:cstudents/entity/StudentEntity.dart';
import 'package:cstudents/pages/home/accountBottomSheet.dart';
import 'package:cstudents/pages/home/designhome.dart';
import 'package:cstudents/pages/home/menu.dart';
import 'package:cstudents/service/studentService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/colors.dart';

StudentEntity globalStudent = StudentEntity();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = FirebaseAuth.instance.currentUser;
  StudentEntity student = StudentEntity();
  bool loading = true;
  var _smsControllar = TextEditingController();
  getAllReady() async {
    globalStudent = student = await StudentDao.getStudentEntity();

    setState(() {
      loading = false;
      globalStudent = student;
      student = student;

      print(student.name);
    });
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

  getPermission() async {
    var status1 = await Permission.sms.status;
    var status2 = await Permission.phone.status;
    if (status1.isDenied) {
      await Permission.sms.request();
    }
    if (status2.isDenied) {
      await Permission.phone.request();
    }
  }

  @override
  void initState() {
    getAllReady();
    getPermission();
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
          "Chemia Galaxy",
          style: GoogleFonts.lato(fontSize: 20),
        ),
        leading: TextButton(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Center(
              child: Icon(
                Icons.person_outline_outlined,
                size: 30,
                color: AppColors.appBar,
              ),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
                // isScrollControlled: true,
                clipBehavior: Clip.hardEdge,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(50, 35),
                        topRight: Radius.elliptical(50, 35))),
                builder: ((context) {
                  return const Account();
                }));
          },
        ),
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          Positioned(
            child: Image.asset(
              "assets/images/bg3.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/bg1.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(106, 255, 255, 255),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.appBar),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      DecoHome(),
                      Expanded(flex: 1, child: SizedBox()),
                      Menu()
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:cstudents/pages/home/Home.dart';
import 'package:cstudents/util/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: Container()),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.appBar,
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50000),
                      border: Border.all(color: AppColors.appBar as Color),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 185, 185, 185),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.appBar,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "${globalStudent.name}",
                style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appBar),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topLeft,
              child: Text(
                "Account info",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appBar),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, top: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appBar,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                            size: 25,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${globalStudent.balance}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBar),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appBar,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 25,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${globalStudent.sclass}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBar),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appBar,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 25,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${globalStudent.batch}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBar),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appBar,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 25,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${globalStudent.studentNumber}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBar),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.appBar,
                              borderRadius: BorderRadius.circular(7)),
                          child: const Icon(
                            Icons.phone_forwarded,
                            color: Colors.white,
                            size: 25,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${globalStudent.gaurdianNumber}",
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBar),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                onPressed: () {
                  Navigator.pop(context);
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 36,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.splashColor),
                  child: Text(
                    "Sign Out",
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 231, 111, 102)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

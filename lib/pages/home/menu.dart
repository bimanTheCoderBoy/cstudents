import 'package:cstudents/pages/Quiz/Quizes.dart';
import 'package:cstudents/pages/anouncement/anouncement.dart';
import 'package:cstudents/pages/fees/fees.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:cstudents/pages/payment/mainPaymentPage.dart';
import 'package:cstudents/pages/results/results.dart';
import 'package:cstudents/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Notes/NoteClass.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      height: 70,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff6070AB), Color(0xff9FB3F8)]),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(211, 159, 178, 248),
                spreadRadius: 3,
                blurRadius: 15)
          ]),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      Notes("files/${globalStudent.sclass}"),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.import_contacts,
                  color: Colors.white,
                  size: 27,
                ),
                Text(
                  "Notes",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const Results(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 27,
                ),
                Text(
                  "Results",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ))),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Quizes()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: AppColors.appBar,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(115, 204, 204, 204),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: Center(
                    child: Text(
                      "Q",
                      style: GoogleFonts.salsa(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                  ),
                ),
                Text(
                  "Quizes",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Fees()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 27,
                ),
                Text(
                  "Fees",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 10),
                )
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Anouncement(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.newspaper,
                  color: Colors.white,
                  size: 27,
                ),
                Text(
                  "News",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

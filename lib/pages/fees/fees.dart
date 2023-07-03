import 'package:cstudents/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../util/colors.dart';

class Fees extends StatefulWidget {
  const Fees({super.key});

  @override
  State<Fees> createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  dynamic account;
  bool isDispose = false;

  loadAccount() {
    if (!isDispose) {
      setState(() {
        account = globalStudent.account;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }

  @override
  void initState() {
    super.initState();
    loadAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 2,
          backgroundColor: AppColors.appBar,
          title: Text(
            "Fees",
            style: GoogleFonts.lato(fontSize: 20),
          ),
          leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: globalStudent.balance == 0
                        ? const Color.fromRGBO(2, 131, 34, 0.286)
                        : const Color.fromARGB(72, 201, 18, 5),
                    blurRadius: 3,
                    spreadRadius: 0),
              ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: (globalStudent.balance == 0)
                  ? Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(48, 110, 231, 140),

                                // Color.fromRGBO(2, 131, 34, 0.407),
                                Color.fromRGBO(2, 131, 34, 0.286),
                              ]),
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(color: Colors.green, width: 2)),
                        child: const Icon(
                          Icons.done_sharp,
                          color: Colors.green,
                          size: 25,
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(47, 231, 110, 110),

                                // Color.fromRGBO(2, 131, 34, 0.407),
                                Color.fromRGBO(131, 2, 2, 0.282),
                              ]),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "₹${globalStudent.balance}",
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 201, 18, 5)),
                      ),
                    ),
            )
          ],
        ),
        body: Container(
            color: AppColors.bgBlue,
            child: account == null
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.appBar),
                  )
                : account.length == 0
                    ? const Center(
                        child: Text("No Result Found"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: account.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 7, right: 7),
                                padding: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(172, 185, 192, 212),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/moneyIcon.jpg',
                                      width: 70,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${account[index]['month']}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.appBar),
                                        ),
                                        Text(
                                          "${account[index]['year']}",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const Expanded(flex: 1, child: SizedBox()),
                                    (!account[index]['isPaid'])
                                        ? Text(
                                            "₹${account[index]['dueMoney']}",
                                            style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 201, 18, 5)),
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Paid",
                                                style: GoogleFonts.openSans(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 17, 156, 29)),
                                              ),
                                              Text(
                                                "${account[index]['paidDate']}",
                                                style: GoogleFonts.lato(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                margin:
                                    const EdgeInsets.only(left: 7, right: 7),
                                padding: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        (account[index]['isPaid'])
                                            ? const Color.fromRGBO(
                                                2, 131, 34, 0.407)
                                            : const Color.fromARGB(
                                                91, 187, 5, 5),
                                        (account[index]['isPaid'])
                                            ? const Color.fromARGB(
                                                48, 110, 231, 140)
                                            : const Color.fromARGB(
                                                66, 245, 84, 84),
                                        const Color.fromARGB(0, 252, 254, 255)
                                      ]),

                                  //
                                ),
                              )
                            ],
                          );
                        },
                      )));
  }
}

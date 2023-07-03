import 'dart:convert';
import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:cstudents/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../../service/studentService.dart';

class DecoHome extends StatefulWidget {
  const DecoHome({super.key});

  @override
  State<DecoHome> createState() => _DecoHomeState();
}

class _DecoHomeState extends State<DecoHome> {
  bool deco = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 50,
              width: 250,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(173, 169, 187, 251),
                        spreadRadius: 1,
                        blurRadius: 7)
                  ],
                  color: AppColors.appBar,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      setState(() {
                        deco = !deco;
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: deco ? Colors.white : AppColors.appBar),
                      child: Center(
                        child: Text(
                          "Performence",
                          style: GoogleFonts.lato(
                              color: deco ? AppColors.appBar : Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      setState(() {
                        deco = !deco;
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: deco ? Colors.transparent : Colors.white),
                      child: Center(
                        child: Text(
                          "Power",
                          style: GoogleFonts.lato(
                              color: deco ? Colors.white : AppColors.appBar,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (deco) CircularBar() else MotivationQuotes()
        ],
      ),
    );
  }
}

//Motivational quotes widget

class MotivationQuotes extends StatefulWidget {
  const MotivationQuotes({super.key});

  @override
  State<MotivationQuotes> createState() => _MotivationQuotesState();
}

class _MotivationQuotesState extends State<MotivationQuotes> {
  late String quotes, owner;
  bool loading = true;
  bool isDispose = false;
  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    quotes = "";
    owner = "";
    getQuotes();
  }

  getQuotes() async {
    if (!isDispose) {
      setState(() {
        loading = true;
      });
    }
    try {
      dynamic response = await http.post(
          Uri.parse('https://api.forismatic.com/api/1.0/'),
          body: {"method": 'getQuote', 'format': 'json', 'lang': 'en'});
      dynamic res = jsonDecode(response.body);
      if (!isDispose) {
        setState(() {
          try {
            quotes = res['quoteText'];

            owner = res['quoteAuthor'].toString().trim();
            loading = false;
          } catch (e) {
            getQuotes();
          }
        });
      }
    } catch (e) {
      getQuotes();
    }
  }

//_copyToClipBoard
  _copyToClipBoard() async {
    await FlutterClipboard.copy(
      "'" "'$quotes'" "'\n\n$owner",
    ).then((value) => Fluttertoast.showToast(
        msg: "Quote copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.splashColor,
        textColor: Color.fromARGB(255, 88, 88, 88),
        fontSize: 16.0));
  }

//_share
  _share() {
    Share.share("'" "'$quotes'" "'\n\n$owner", subject: 'Motivational Quote');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          constraints: BoxConstraints(
            minHeight: 300,
          ),
          width: MediaQuery.of(context).size.width - 30,
          decoration: const BoxDecoration(
              color: Color.fromARGB(12, 0, 0, 0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
          child: Column(
            children: [
              loading
                  ? SizedBox(
                      height: 290,
                      child: Center(
                        child:
                            CircularProgressIndicator(color: AppColors.appBar),
                      ),
                    )
                  : Container(
                      height: 290,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(9, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 25, bottom: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: quotes != "" ? '""' : "",
                                    style: const TextStyle(
                                        fontFamily: 'Ic',
                                        fontSize: 30,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: quotes != "" ? quotes : "",
                                          style: const TextStyle(
                                              fontFamily: 'Ic',
                                              fontSize: 30,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: quotes != "" ? '""' : "",
                                          style: const TextStyle(
                                              fontFamily: 'Ic',
                                              fontSize: 30,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700))
                                    ])),
                            Text("\n$owner",
                                style: const TextStyle(
                                    fontFamily: 'Ic',
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 50, 112, 75),
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                    ),

              //Share functionality
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.splashColor,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () async {
                          await _copyToClipBoard();
                        },
                        child: Icon(
                          Icons.copy,
                          size: 30,
                          color: AppColors.appBar,
                        )),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.splashColor,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () async {
                        await getQuotes();
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 30,
                        color: AppColors.appBar,
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.splashColor,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          _share();
                        },
                        child: Icon(
                          Icons.share_sharp,
                          size: 30,
                          color: AppColors.appBar,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

//progress bar circular

class CircularBar extends StatelessWidget {
  CircularBar({super.key});

  double progress = StudentService.getPerformance();
  // double progress = 60.0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 70),
            child: CircularSeekBar(
              width: double.infinity,
              height: 220,
              progress: progress,
              // curves: Curves.bounceOut,
              barWidth: 7,
              startAngle: 195,
              sweepAngle: 360,
              strokeCap: StrokeCap.butt,
              progressColor: const Color(0xff9FB3F8),
              innerThumbRadius: 4,
              animDurationMillis: 1500,
              trackColor: Colors.transparent,
              innerThumbStrokeWidth: 3,
              innerThumbColor: Colors.white,
              outerThumbRadius: 5,
              outerThumbStrokeWidth: 10,
              outerThumbColor: const Color(0xff9FB3F8),
              animation: true,
              valueNotifier: _valueNotifier,
              child: Center(
                child: Container(
                  height: 150,
                  width: 152,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5000),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(211, 159, 178, 248),
                            spreadRadius: 1,
                            blurRadius: 20)
                      ]),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: _valueNotifier,
                      child: null,
                      builder: (_, double value, __) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${value.round()}%",
                              style: GoogleFonts.shanti(
                                  fontSize: 35,
                                  // fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 73, 92, 152)),
                            ),
                          ),
                          Positioned(
                            bottom: 22,
                            child: Text(
                              (progress < 50)
                                  ? "😣"
                                  : (progress > 50 && progress < 70)
                                      ? "🙂"
                                      : (progress > 70 && progress < 85)
                                          ? "🤓"
                                          : "🔥",
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            (progress < 50)
                ? "Work hard! your performence is very low"
                : (progress > 50 && progress < 70)
                    ? "You can do better"
                    : (progress > 70 && progress < 75)
                        ? "Wow! you are doing very well"
                        : "Excellent! you are doing Great",
            style: const TextStyle(color: Color.fromARGB(255, 118, 118, 118)),
          ),
        )
      ],
    );
  }
}

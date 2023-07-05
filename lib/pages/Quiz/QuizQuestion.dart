import 'package:cstudents/main.dart';
import 'package:cstudents/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:themed/themed.dart';

import '../../dao/QuizDao.dart';
import '../../entity/Quiz.dart';

class QuizPage extends StatefulWidget {
  Quiz quiz;
  QuizPage(this.quiz, {super.key});

  @override
  State<QuizPage> createState() => _QuizPageState(quiz);
}

class _QuizPageState extends State<QuizPage> {
  Quiz quiz;
  _QuizPageState(this.quiz);

  List<int> score = [];
  int totalQuestions = 0;
  int indexQuestion = 0;
  load() async {
    if (mounted) {
      setState(() {
        totalQuestions = quiz.questions.length;
      });
    }
    for (var i = 0; i < totalQuestions; i++) {
      score.add(-1);
    }
  }

  pressAns(int indexAns) {
    if (mounted) {
      setState(() {
        if (indexAns == score[indexQuestion]) {
          score[indexQuestion] = -1;
        } else {
          score[indexQuestion] = indexAns;
        }
      });
    }
  }

  validateScore() {
    int scoreValue = 0;
    for (var i = 0; i < totalQuestions; i++) {
      int ind = 0;
      int ansValue = -2;
      quiz.questions[i].answers.forEach((key, value) {
        if (value) {
          ansValue = ind;
        }
        ind++;
      });
      if (score[i] == ansValue) {
        scoreValue++;
      }
    }
    return scoreValue;
  }
  // evaluateAns() {
  //   int correctAns = -2;
  //   int index = 0;
  //   quiz.questions[indexQuestion].answers.forEach((key, value) {
  //     if (value) {
  //       score[indexQuestion] = index;
  //     }
  //     index++;
  //   });
  //   if (chooseAns == chooseAns) {
  //     score[indexQuestion] = true;
  //   }
  //   chooseAns = -1;
  // }

  @override
  void initState() {
    super.initState();
    load();
  }

  bool isSubmitPage = false;
  int scoreValue = -1;
  submitPageUpdate() async {
    await updateQuizResults(validateScore(), quiz);
    scoreValue = validateScore();
    if (mounted) {
      setState(() {});
    }
  }

  //backbutton override
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                insetPadding: EdgeInsets.all(15),
                backgroundColor: AppColors.appBar,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Do you want to Quit ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, left: 25, right: 25, bottom: 15),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red
                                // )
                              ),
                            ),
                            onPressed: () {
                              // Navigator.pop(context);
                              // Navigator.pop(context);
                              Navigator.of(context).pop(true);
                            },
                            child: Container(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "Quit",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red
                                // )
                              ),
                            ),
                            onPressed: () async {
                              // Navigator.pop(context);
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    "No",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            })) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    backdialog() => showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              insetPadding: EdgeInsets.all(15),
              backgroundColor: AppColors.appBar,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Do you want to Quit ?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 15, left: 25, right: 25, bottom: 15),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red
                              // )
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Quit",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red
                              // )
                            ),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
    submitdialog() => showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              insetPadding: EdgeInsets.all(15),
              backgroundColor: AppColors.appBar,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Do you want to Submit your Quiz?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 15, left: 25, right: 25, bottom: 15),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red
                              // )
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red
                              // )
                            ),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);

                            setState(() {
                              isSubmitPage = true;
                            });
                            submitPageUpdate();
                          },
                          child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Material(
          color: AppColors.appBar,
          child: isSubmitPage
              ? SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Result",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      (scoreValue == -1)
                          ? SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "getting your result",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500),
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${scoreValue}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 3,
                                    ),
                                    Text("${totalQuestions}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )),
                      SizedBox(
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red
                              // )
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              width: 250,
                              child: Center(
                                child: Text(
                                  "Goto Quiz Page",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Text(
                            "Question  ${indexQuestion + 1}/$totalQuestions",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.cyanAccent,
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${quiz.questions[indexQuestion].name as String}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                                Container(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      String ans = "";
                                      int i = 0;
                                      quiz.questions[indexQuestion].answers
                                          .forEach(
                                        (key, value) {
                                          if (i == index) {
                                            ans = key;
                                          }
                                          i++;
                                        },
                                      );

                                      return InkWell(
                                        onTap: () => pressAns(index),
                                        child: Card(
                                          color: (score[indexQuestion] == index)
                                              ? Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  color:
                                                      (score[indexQuestion] ==
                                                              index)
                                                          ? Color.fromARGB(
                                                              255, 67, 154, 70)
                                                          : Colors.cyanAccent)),
                                          child: Row(children: [
                                            Container(
                                              margin: EdgeInsets.all(8),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(
                                                            187, 160, 160, 160),
                                                        blurRadius: 3,
                                                        spreadRadius: 1)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
                                                  color:
                                                      (score[indexQuestion] ==
                                                              index)
                                                          ? Color.fromARGB(
                                                              255, 67, 154, 70)
                                                          : Colors.cyan),
                                              child: Center(
                                                  child: Text(
                                                String.fromCharCode(65 + index),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: Text(
                                                    ans,
                                                    style: TextStyle(
                                                        color:
                                                            (score[indexQuestion] ==
                                                                    index)
                                                                ? Colors.black87
                                                                : Colors.white,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: SizedBox(),
                      // ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    // side: BorderSide(color: Colors.red
                                    // )
                                  ),
                                ),
                                onPressed: () async {
                                  if (indexQuestion == 0) {
                                    backdialog();
                                  } else {
                                    if (mounted) {
                                      setState(() {
                                        indexQuestion--;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                    height: 43,
                                    width: 80,
                                    child: Center(
                                        child: Text(
                                      (indexQuestion == 0) ? "Back" : "Prev",
                                      style: TextStyle(fontSize: 19),
                                    )))),
                            Expanded(flex: 1, child: SizedBox()),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    // side: BorderSide(color: Colors.red
                                    // )
                                  ),
                                ),
                                onPressed: () async {
                                  if (indexQuestion + 1 == totalQuestions) {
                                    // await updateQuizResults(validateScore(), quiz);
                                    await submitdialog();
                                  } else {
                                    if (mounted) {
                                      setState(() {
                                        indexQuestion++;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 43,
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      (indexQuestion + 1 == totalQuestions)
                                          ? "Submit"
                                          : "Next",
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}

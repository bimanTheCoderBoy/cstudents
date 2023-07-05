import 'package:cstudents/dao/QuizDao.dart';
import 'package:cstudents/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../entity/Quiz.dart';
import '../../util/colors.dart';
import 'QuizQuestion.dart';

class Quizes extends StatefulWidget {
  const Quizes({super.key});

  @override
  State<Quizes> createState() => _QuizesState();
}

class _QuizesState extends State<Quizes> {
  List<Quiz>? quizArray;
  load() async {
    quizArray = await readQuizes();
    if (mounted) {
      setState(() {
        quizArray;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        backgroundColor: AppColors.appBar,
        title: Text(
          "Quizes",
          style: GoogleFonts.lato(fontSize: 20),
        ),
        leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: quizArray == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : quizArray!.isEmpty
              ? const Center(
                  child: Text("No result found"),
                )
              : ListView.builder(
                  itemCount: quizArray!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      color: Color.fromARGB(150, 109, 122, 164),
                      shadowColor: Color.fromARGB(198, 0, 0, 0),
                      elevation: 15,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " ${quizArray![index].name as String}"
                                                  .length <=
                                              25
                                          ? " ${quizArray![index].name as String}"
                                          : " ${quizArray![index].name as String}"
                                                  .substring(0, 23) +
                                              "..",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 31),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color:
                                              Color.fromARGB(255, 195, 14, 2),
                                        ),
                                        Text(
                                            "${quizArray![index].time as String} minutes",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 31, 31, 31),
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey[700]),
                                            onPressed: () {},
                                            child: Text(
                                              "Total: " +
                                                  "${quizArray![index].questions.length}",
                                              style: TextStyle(
                                                  color: Colors.amber),
                                            )),
                                        Expanded(flex: 1, child: SizedBox()),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // if (!quizArray![index].isGivenAlready)
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 100,
                              height: 110,
                              color: Colors.black45,
                              child: Center(
                                child: quizArray![index].isGivenAlready
                                    ? Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white60,
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: Color.fromARGB(
                                                255, 19, 37, 95)),
                                        child: Center(
                                          child: Text(
                                            "${globalStudent.quizMap![quizArray![index].id as String]}",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    : IconButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  QuizPage(quizArray![index]),
                                            ),
                                          );
                                          load();
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                              color: Colors.white60),
                                          child: Icon(
                                            Icons.arrow_circle_right_rounded,
                                            color:
                                                Color.fromARGB(255, 19, 37, 95),
                                          ),
                                        ),
                                        iconSize: 40,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}

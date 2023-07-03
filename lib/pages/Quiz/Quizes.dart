import 'package:cstudents/dao/QuizDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../entity/Quiz.dart';
import '../../util/colors.dart';

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
                    return Text(quizArray![index].name as String);
                  },
                ),
    );
  }
}

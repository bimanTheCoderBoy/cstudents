import 'package:flutter/material.dart';

class AppColors {
  static Color? appBar = const Color.fromARGB(255, 77, 97, 160);
  static Color? bodywhite = const Color.fromARGB(255, 239, 230, 247);
  static Color? splashColor = const Color.fromARGB(73, 77, 96, 160);
  static Color? bgBlue = Color.fromARGB(34, 173, 190, 254);
}

class Component {
  static Widget loading = Center(
    child: Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
              color: Color.fromARGB(255, 111, 140, 236)),
          const SizedBox(
            width: 25,
          ),
          Text(
            "loading",
            style: TextStyle(color: AppColors.appBar),
          )
        ],
      ),
    ),
  );
}

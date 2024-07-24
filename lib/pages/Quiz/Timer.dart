import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;
  @override
  void onReady() {
    // _startTimer(10);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      int minutes = remainSeconds ~/ 60;
      int seconds = remainSeconds % 60;
      time.value = minutes.toString().padLeft(2, "0") +
          ":" +
          seconds.toString().padLeft(2, "0");
      if (remainSeconds == 0) {
        print("I am closed");
        timer.cancel();
        onClose();
      } else {
        remainSeconds--;
      }
    });
  }
}

class MyTimer extends GetView<TimerController> {
  const MyTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Text(
        '${controller.time.value}',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      );
    });
  }
}

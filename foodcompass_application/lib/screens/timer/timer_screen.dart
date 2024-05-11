import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/text_style_constant.dart';
import 'package:foodcompass_application/widgets/button_global_widget.dart';

class TimerScreen extends StatefulWidget {
  final int minutes;
  const TimerScreen({super.key, required this.minutes});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int minutesLeft;
  late int secondsLeft;
  late bool isRunning;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    minutesLeft = widget.minutes;
    secondsLeft = 0;
    isRunning = false;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsLeft == 0) {
          if (minutesLeft == 0) {
            timer.cancel();
            return;
          }
          minutesLeft--;
          secondsLeft = 59;
        } else {
          secondsLeft--;
        }
      });
    });
  }

  void toggleTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      startTimer();
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstant.colorOrange),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Food',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorBlack,
                  fontSize: 20.0,
                ),
              ),
              TextSpan(
                text: 'Compass',
                style: TextStyleConstant.poppinsMedium.copyWith(
                  color: ColorConstant.colorOrange,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${minutesLeft.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}',
              style: TextStyleConstant.poppinsMedium.copyWith(
                color: ColorConstant.colorBlack,
                fontSize: 40.0,
              ),
            ),
            const SizedBox(height: 20),
            ButtonGlobalWidget(
              height: 50,
              width: 150,
              onTap: toggleTimer,
              title: isRunning ? 'Pause' : 'Start',
              color: ColorConstant.colorOrange,
              textColor: ColorConstant.colorWhite,
            )
          ],
        ),
      ),
    );
  }
}

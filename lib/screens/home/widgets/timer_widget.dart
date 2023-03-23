import 'package:flutter/material.dart';
import 'package:time/time.dart';
import 'dart:async';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration studyTime = 0.minutes;
  Duration minus = 1.seconds;
  Duration init = 0.seconds;
  bool isTimerRunning = false;
  bool isTimerPaused = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SleekCircularSlider(
            min: 0,
            max: 60,
            initialValue: 0.0,
            appearance: CircularSliderAppearance(
              customWidths:
                  CustomSliderWidths(progressBarWidth: 20, trackWidth: 15),
              size: 300,
              startAngle: 290,
              angleRange: 320,
              infoProperties: InfoProperties(
                mainLabelStyle: theme.textTheme.displayLarge,
                modifier: (double value) {
                  return display();
                },
              ),
              counterClockwise: false,
              customColors: CustomSliderColors(
                progressBarColor: theme.colorScheme.secondary,
                trackColor: theme.colorScheme.primary,
                dotColor: theme.colorScheme.background,
              ),
            ),
            onChange: (value) {
              setState(() {
                studyTime = Duration(minutes: value.toInt());
                // if slider is changes during countdown
                // countdown should pause and countinue when
              });
            },
          ),
        ),
        const Padding(padding: EdgeInsets.all(20)),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.background,
              side: BorderSide(
                color: theme.colorScheme.outline,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (!isTimerRunning) {
                startTimer();
              }
            },
            child: Text(
              'Begin',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 30,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.background,
              side: BorderSide(
                color: theme.colorScheme.outline,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              cancelTimer();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 30,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.background,
              side: BorderSide(
                color: theme.colorScheme.outline,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              pauseTimer();
            },
            child: Text(
              'Pause',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // To begin the countdown timer
  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(1.seconds, (timer) {
      setState(() {
        studyTime -= minus;
        if (studyTime <= Duration.zero) {
          isTimerRunning = false;
          timer.cancel();
        }
      });
    });
    isTimerRunning = true;
  }

  //To pause the countdown timer
  void pauseTimer() {
    if (timer != null && isTimerRunning && !isTimerPaused) {
      timer!.cancel();
      isTimerPaused = true;
    } else if (isTimerPaused) {
      startTimer();
      isTimerPaused = false;
    }
  }

  //To cancel the countdown timer
  void cancelTimer() {
    if (isTimerRunning && !isTimerPaused | isTimerPaused) {
      /// slider set to start
      setState(() {
        studyTime = Duration.zero;
      });
      timer!.cancel();
      isTimerRunning = false;
    }
  }

  String display() {
    int remainingSeconds = studyTime.inSeconds;
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

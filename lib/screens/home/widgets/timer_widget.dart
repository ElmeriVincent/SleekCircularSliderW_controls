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
  double value = 0;
  Duration maxStudyTime = 60.minutes;
  Duration minus = 1.seconds;
  bool isTimerRunning = false;
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
            appearance: CircularSliderAppearance(
              customWidths:
                  CustomSliderWidths(progressBarWidth: 20, trackWidth: 15),
              size: 300,
              startAngle: 290,
              angleRange: 320,
              infoProperties: InfoProperties(
                mainLabelStyle: theme.textTheme.displayLarge,
                modifier: (double value) {
                  int remainingSeconds = maxStudyTime.inSeconds;
                  int minutes = (remainingSeconds / 60).floor();
                  int seconds = remainingSeconds % 60;
                  return '$minutes:${seconds.toString().padLeft(2, '0')}';
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
                value = value;
                maxStudyTime = Duration(minutes: value.toInt());
              });
            },
            onChangeEnd: (value) {
              setState(() {
                maxStudyTime = Duration(minutes: value.toInt());
              });
            },
            min: 0,
            max: 60,
            initialValue: 0,
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
      ],
    );
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(1.seconds, (timer) {
      setState(() {
        maxStudyTime -= minus;
        if (maxStudyTime <= Duration.zero) {
          isTimerRunning = false;
          timer.cancel();
        }
      });
    });
    isTimerRunning = true;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

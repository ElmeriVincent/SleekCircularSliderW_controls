import 'package:flutter/material.dart';
import 'package:time/time.dart';
import 'dart:async';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

enum TimerStatus {
  running,
  paused,
  stopped,
}

class _TimerWidgetState extends State<TimerWidget> {
  double initialSliderValue = 0.0;
  Duration _studyTime = Duration.zero;
  late Timer timer;
  TimerStatus _timerStatus = TimerStatus.stopped;

  double maxSliderValue = 60.0; // set max value to 60 minutes
  double minSliderValue = 0.0; // set min value to 0 seconds

  @override
  void initState() {
    super.initState();
    // Initialize the initial slider value to the study time in minutes
    initialSliderValue = _studyTime.inSeconds.toDouble();
  }

  void _initializeTimer() {
    // Check that the initial slider value is within the valid range of 0 to 60
    assert(initialSliderValue >= 0 && initialSliderValue <= 60);
    // Set up a periodic timer to decrement the study time every second
    timer = Timer.periodic(1.seconds, (timer) {
      setState(() {
        _studyTime -= const Duration(seconds: 1);
        // If the study time reaches zero,
        // cancel the timer and set the timer status to stopped
        if (_studyTime <= Duration.zero) {
          timer.cancel();
          _timerStatus = TimerStatus.stopped;
        }
      });
    });
  }

  // To begin the countdown timer
  void startTimer() {
    if (_timerStatus == TimerStatus.running) {
      // If the timer is already running, cancel the timer
      timer.cancel();
    }
    // Initialize the timer and set the timer status to running
    _initializeTimer();
    _timerStatus = TimerStatus.running;
  }

  void pauseTimer() {
    if (_timerStatus == TimerStatus.running) {
      timer.cancel();
      _timerStatus = TimerStatus.paused;
    } else if (_timerStatus == TimerStatus.paused) {
      _initializeTimer();
      _timerStatus = TimerStatus.running;
    }
  }

  //To cancel the countdown timer
  void cancelTimer() {
    if (_timerStatus != TimerStatus.stopped) {
      // If the timer is running or paused,
      // cancel the timer and set the timer status to stopped
      timer.cancel();
      _timerStatus = TimerStatus.stopped;
      // Reset the study time to zero
      setState(() {
        _studyTime = Duration.zero;
      });
    }
  }

  // Get the remaining time in the format mm:ss
  String get remainingTimeDisplay {
    int remainingSeconds = _studyTime.inSeconds;
    int minutes = (remainingSeconds / 60).floor();
    int seconds = remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SleekCircularSlider(
      initialValue: initialSliderValue,
      min: minSliderValue,
      max: maxSliderValue,
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          handlerSize: 10,
          shadowWidth: 50,
          progressBarWidth: 30,
          trackWidth: 10,
        ),
        size: 300,
        startAngle: 290,
        angleRange: 320,
        infoProperties: InfoProperties(
          mainLabelStyle: theme.textTheme.displayLarge,
          modifier: (double value) {
            return remainingTimeDisplay;
          },
        ),
        counterClockwise: false,
        customColors: CustomSliderColors(
          progressBarColor: theme.colorScheme.secondary,
          trackColor: theme.colorScheme.primary,
          dotColor: theme.colorScheme.background,
        ),
      ),
      onChangeStart: (startValue) => pauseTimer(),
      onChange: (double value) {
        // update study time duration based on slider value
        setState(() {
          _studyTime = Duration(minutes: value.toInt());
        });
      },
      onChangeEnd: (endValue) {
        _studyTime = Duration(minutes: endValue.toInt());
        if (_timerStatus == TimerStatus.stopped) {
          startTimer();
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

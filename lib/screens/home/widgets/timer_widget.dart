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

  @override
  void initState() {
    super.initState();
    // Initialize the initial slider value to the study time in minutes
    initialSliderValue = _studyTime.inMinutes.toDouble();
  }

  void _initializeTimer() {
    // Convert the study time to minutes and set the initial slider value
    initialSliderValue = _studyTime.inSeconds / 60;
    // Check that the initial slider value is within the valid range of 0 to 60
    try {
      assert(initialSliderValue >= 0 && initialSliderValue <= 61);
    } catch (e) {
      throw Exception('Invalid slider value: $initialSliderValue');
    }
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

  //To pause the countdown timer
  void pauseTimer() {
    if (_timerStatus == TimerStatus.running) {
      // If the timer is running,
      // cancel the timer and set the timer status to paused
      timer.cancel();
      _timerStatus = TimerStatus.paused;
    } else if (_timerStatus == TimerStatus.paused) {
      // If the timer is paused,
      // initialize the timer and set the timer status to running
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

  // This function is called when the user changes the study time slider
  void _handleDurationChange(double value) {
    int newMinutes = value.toInt();
    // Check if the new value is within the valid range of 1 to 60 minutes
    if (newMinutes < 0 || newMinutes > 60) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Congrats! Impossible error unlocked.'),
        ),
      );
      return;
    }
    setState(() {
      _studyTime = Duration(minutes: newMinutes);
    });
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
      min: 0,
      max: 60,
      initialValue: _studyTime.inSeconds / 60,
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
      onChange: _handleDurationChange,
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

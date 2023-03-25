import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

// Define an enumeration for the different states of the timer.
enum TimerStatus { running, paused, stopped }

class _TimerWidgetState extends State<TimerWidget> {
  // Define the minimum and maximum values for the slider.
  double minSliderValue = 0;
  double maxSliderValue = 60;

  // Initialize the duration of the study time to zero and the timer status to stopped.
  Duration _studyTime = Duration.zero;
  TimerStatus _timerStatus = TimerStatus.stopped;

  // Define a Timer object that will be used to update the study time.
  late Timer _timer;

  // This function is called when the slider value changes.
  void _onSliderChange(double value) {
    // Update the study time based on the new slider value.
    setState(() {
      _studyTime = Duration(minutes: value.toInt());
    });
  }

  // This function is called when the user releases the slider.
  void _onSliderChangeEnd(double endValue) {
    // Round the study time to the nearest minute.
    _studyTime = Duration(minutes: endValue.round());

    // If the timer is stopped and the study time is greater than zero, start the timer.
    if (_timerStatus == TimerStatus.stopped && _studyTime > Duration.zero) {
      startTimer();
    }
  }

  void startTimer() {
    _timerStatus = TimerStatus.running;
    // Set up a periodic timer that updates the study time.
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        if (_studyTime.inSeconds > 0) {
          _studyTime = _studyTime - const Duration(seconds: 1);
        } else {
          // If the study time is up, cancel the timer and set the timer status to stopped.
          _timerStatus = TimerStatus.stopped;
          timer.cancel();
        }
      });
    });
  }

  // This function is called when the widget is disposed to cancel the timer and avoid memory leaks.
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // This getter returns a formatted string to display the remaining study time.
  String get remainingTimeDisplay =>
      '${_studyTime.inMinutes}:${(_studyTime.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SleekCircularSlider(
      initialValue: _studyTime.inMinutes.toDouble(),
      min: minSliderValue,
      max: maxSliderValue,
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          handlerSize: 5,
          shadowWidth: 50,
          progressBarWidth: 15,
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
      onChange: _onSliderChange,
      onChangeEnd: _onSliderChangeEnd,
    );
  }
}

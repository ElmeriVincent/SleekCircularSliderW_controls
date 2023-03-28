import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

enum TimerStatus { running, paused, stopped }

class _TimerWidgetState extends State<TimerWidget> {
  double minSliderValue = 0;
  double maxSliderValue = 60;
  Duration _studyTime = Duration.zero;
  TimerStatus _timerStatus = TimerStatus.stopped;
  late Timer _timer;

  void _onSliderChange(double value) {
    setState(() {
      _studyTime = Duration(minutes: value.toInt());
    });
  }

  void _onSliderChangeEnd(double endValue) {
    _studyTime = Duration(minutes: endValue.round());

    if (_timerStatus == TimerStatus.stopped && _studyTime > Duration.zero) {
      startTimer();
    }
  }

  void startTimer() {
    _timerStatus = TimerStatus.running;

    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        if (_studyTime.inSeconds > 0) {
          _studyTime = _studyTime - const Duration(seconds: 1);
        } else {
          _timerStatus = TimerStatus.stopped;
          timer.cancel();
        }
      });
    });
  }

  String get remainingTimeDisplay =>
      '${_studyTime.inMinutes}:${(_studyTime.inSeconds % 60).toString().padLeft(2, '0')}';

  Widget _timerControlIcon() {
    return IconButton(
      icon: _timerStatus == TimerStatus.running
          ? const Icon(Icons.pause)
          : const Icon(Icons.play_arrow),
      color: Colors.deepPurple,
      iconSize: 48,
      onPressed: () {
        setState(() {
          if (_timerStatus == TimerStatus.running) {
            _timerStatus = TimerStatus.paused;
            _timer.cancel();
          } else if (_timerStatus == TimerStatus.paused) {
            startTimer();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SleekCircularSlider(
          initialValue: _studyTime.inMinutes.toDouble(),
          min: minSliderValue,
          max: maxSliderValue,
          appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(
              handlerSize: 10,
              progressBarWidth: 30,
              trackWidth: 20,
            ),
            size: 300,
            startAngle: 290,
            angleRange: 320,
            counterClockwise: false,
            customColors: CustomSliderColors(
              shadowMaxOpacity: 0,
              progressBarColor: Colors.deepPurple,
              trackColor: Colors.black26,
            ),
          ),
          onChange: _onSliderChange,
          onChangeEnd: _onSliderChangeEnd,
          innerWidget: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  remainingTimeDisplay,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _timerControlIcon(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

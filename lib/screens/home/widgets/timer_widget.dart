import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

enum TimerStatus { running, paused, stopped }

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  // Animation controller used to control the progress indicator animation
  late AnimationController _controller;

  // Current status of the timer
  late TimerStatus _status;

  // Current progress of the timer, as a value between 0 and 1
  double _progress = 0;

  // Duration of the timer, in seconds
  int _duration = 10; // in seconds

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the duration of the timer
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _duration),
    )

      // Update the progress value whenever the animation changes
      ..addListener(() {
        setState(() {
          _progress = _controller.value;
        });
      })

      // When the animation completes, update the status to "stopped"
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _status = TimerStatus.stopped;
          });
        }
      });

    // Set the initial status to "stopped"
    _status = TimerStatus.stopped;
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed from the tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme for the app
    final theme = Theme.of(context);

    // Build the widget tree
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Build the circular progress indicator, with the value based on the current progress
          CircularProgressIndicator(
            value: 1 - _progress,
            valueColor: AlwaysStoppedAnimation(
                theme.colorScheme.primary.withOpacity(0.9)),
            strokeWidth: 30,
            backgroundColor: theme.colorScheme.secondary,
          ),

          // Build the progress display (either a play button, a countdown, or a "done" icon)
          Center(child: buildProgress()),
        ],
      ),
    );
  }

  Widget buildProgress() {
    if (_status == TimerStatus.stopped) {
      // Build the play button, which starts the timer when pressed
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            _status = TimerStatus.running;
          });
          _controller.reset();
          _controller.forward();
        },
      );
    } else if (_status == TimerStatus.running) {
      // Build the countdown display, which shows the remaining time
      return Text(
        '${(_duration * (1 - _progress)).ceil()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      );
    } else {
      // Build the "done" icon, which indicates that the timer has finished
      return const Icon(
        Icons.done,
        color: Colors.green,
        size: 56,
      );
    }
  }
}

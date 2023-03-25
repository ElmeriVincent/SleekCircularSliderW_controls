import 'package:flutter/material.dart';
import 'package:noni/screens/home/widgets/timer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: TimerWidget(),
        ),
      ),
    );
  }
}

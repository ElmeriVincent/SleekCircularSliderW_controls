import 'package:flutter/material.dart';
import '../../themes.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final slider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(progressBarWidth: 20, trackWidth: 15),
        size: 250,
        startAngle: 270,
        angleRange: 360,
        infoProperties: InfoProperties(
          mainLabelStyle: theme.textTheme.displayLarge,
        ),
        counterClockwise: false,
        customColors: CustomSliderColors(
          progressBarColor: theme.colorScheme.secondary,
          trackColor: theme.colorScheme.primary,
        ),
      ),
      onChange: (double value) {
        print(value);
      },
      min: 0,
      max: 100,
      initialValue: 0,
    );

    return Scaffold(
      body: Center(
        child: slider,
      ),
    );
  }
}

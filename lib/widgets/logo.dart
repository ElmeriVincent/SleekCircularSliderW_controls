import 'package:flutter/material.dart';

import '../themes.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Image.asset(
      currentTheme.currentTheme == ThemeMode.light
          ? 'assets/darkLogo.png'
          : 'assets/lightLogo.png',
      key: ValueKey(theme.brightness),
    );
  }
}

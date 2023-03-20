import 'package:flutter/material.dart';
import 'package:noni/themes.dart';

import '../../widgets/logo.dart';

/*
          IconButton(
            icon: Icon(
              Icons.brightness_4_rounded,
              color: theme.primaryColor,
              size: 40,
            ),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          ),
*/

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.brightness_4_rounded,
              color: theme.colorScheme.secondary,
              size: 40,
            ),
            onPressed: () {
              currentTheme.toggleTheme();
            },
          ),
          Text('Hei ', style: theme.textTheme.displayLarge),
          Text('Time to study!', style: theme.textTheme.bodyMedium),
          const Padding(padding: EdgeInsets.all(20)),
          const Logo(),
          const Padding(padding: EdgeInsets.all(20)),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onBackground,
                foregroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Login',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.surface,
                foregroundColor: theme.colorScheme.onPrimary,
                side: BorderSide(
                  color: theme.colorScheme.secondary,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Register',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

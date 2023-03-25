import 'package:flutter/material.dart';
import 'package:noni/screens/home/home_screen.dart';

import '../../widgets/logo.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Noni',
              style: theme.textTheme.displayLarge,
              textAlign: TextAlign.start,
            ),
            Text(
              'Time to study a little...',
              style: theme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(20.0), child: Logo()),
            _loginButton(context)
          ],
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.onBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

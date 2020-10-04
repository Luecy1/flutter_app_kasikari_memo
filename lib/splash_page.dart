import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    load(context);

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> load(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacementNamed('/list');
  }
}

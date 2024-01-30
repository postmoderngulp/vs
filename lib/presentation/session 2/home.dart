import 'package:flutter/material.dart';
import 'package:vs1/style/fontStyle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          body: Center(
            child: Text(
              'Home',
              style: fontStyle.title,
            ),
          ),
        )));
  }
}

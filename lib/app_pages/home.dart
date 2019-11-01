import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/TouchCounter_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Opacity(
        opacity: 0.0,
        child: Scaffold(
          body: Column(

          ),
        ),
      ),
    );
  }
}

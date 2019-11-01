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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    '1000',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Text('1000000000'),
                      Text('1000000000'),
                      Text('1000000000'),
                      Text('1000000000'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<Counter>(context, listen: false).increment(),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFFCC00),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rubik',
                  fontSize: 150,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

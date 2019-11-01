import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<Counter>(context, listen: false).increment(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
//                    color: Colors.blue,
        ),
        child: Consumer<Counter>(
          builder: (context, counter, child) => Text(
            '${counter.value}',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

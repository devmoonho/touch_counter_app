import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  List<IconData> _icons = [
    FontAwesomeIcons.minus,
    FontAwesomeIcons.trashAlt,
  ];

  Widget _buildIcon(int index) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 5.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () {
            if (index == 0) {
              Provider.of<CounterProvider>(context, listen: false).decrement();
            } else if (index == 1) {
              Provider.of<CounterProvider>(context, listen: false).reset();
            }
          },
          child: Icon(
            _icons[index],
            size: 60.0,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons
            .asMap()
            .entries
            .map(
              (MapEntry map) => _buildIcon(map.key),
            )
            .toList(),
      ),
    );
  }
}

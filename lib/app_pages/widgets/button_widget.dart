import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.minus,
    FontAwesomeIcons.trashAlt,
  ];

  Widget _buildIcon(int index) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Theme.of(context).accentColor : Color(0xFFE7EBEE),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Icon(
        _icons[index],
        size: 60.0,
        color: _selectedIndex == index ? Theme.of(context).primaryColor : Color(0xFFB4C1C4),
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

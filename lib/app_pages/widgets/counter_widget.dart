import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';
import 'package:vibration/vibration.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0)),
      child: Container(
        alignment: MediaQuery.of(context).orientation == Orientation.portrait
            ? Alignment.center
            : Alignment.topCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 5.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                counterProvider.setStartYPos(details.globalPosition.dy);
                setState(() => {});
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                counterProvider.gestureMove(details.globalPosition.dy);
                counterProvider.refresh();
                setState(() => {});
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                if (counterProvider.StartYPos < counterProvider.EndYPos)
                  counterProvider.gestureDown();
                else
                  counterProvider.gestureUp();

                counterProvider.refresh();
                setState(() => {});
              },
              child: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    counterProvider.increment();
                    if (counterProvider.vibration) {
                      Vibration.vibrate();
                    }
                    setState(() {
                      counterProvider.doAnimation();
                    });
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: TextAnimation(
                      child: Container(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0)
                            : EdgeInsets.only(top: 10.0, left: 150.0, right: 150.0),
                        alignment: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Alignment.center
                            : Alignment.topCenter,
                        child: AutoSizeText(
                          '${counterProvider.value}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 150,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _icons
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildIcon(map.key),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Color(0xFFE7EBEE),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            _icons[index],
            size: 25.0,
            color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : Color(0xFFB4C1C4),
          ),
        ),
      ),
    );
  }
}

class TextAnimation extends StatefulWidget {
  final Widget child;

  TextAnimation({this.child});

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.stop(canceled: false);
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context, listen: true);
    counterProvider.setController(_animationController);
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
    );
  }
}

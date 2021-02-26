import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';
import 'package:touch_counter_app/providers/theme_provider.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.penAlt,
    FontAwesomeIcons.folderOpen,
  ];

  Future<void> _loadCondition(List<String> items, CounterProvider counterProvider, StateSetter setState) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: double.maxFinite,
            height: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "OPEN COUNTER",
                      style: Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(items[index]),
                        onDismissed: (direction) {
                          counterProvider.removePreference(items[index]);
                        },
                        direction: DismissDirection.endToStart,
                        background: Card(
                          color: Colors.red,
                          child: Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Delete',
                                  style:
                                      Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).accentColor),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                        child: InkWell(
                            onTap: () {
                              counterProvider.getPreference(items[index]).whenComplete(() {
                                setState(() {});
                                Navigator.of(context).pop();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: counterProvider.currentKey == items[index]
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColorLight),
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                    title: Text(
                                  '${items[index]}',
                                  style: Theme.of(context).textTheme.headline6.apply(
                                      color: counterProvider.currentKey == items[index]
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColor),
                                )),
                              ),
                            )),
                      );
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "OK",
                      style: Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).backgroundColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> _saveCondition(CounterProvider counterProvider) async {
    TextEditingController _controller;
    _controller = new TextEditingController(text: _currentTime());
    _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: double.maxFinite,
            height: 240.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "SAVE COUNTER",
                      style: Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _controller,
                      autofocus: true,
                      style: Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).highlightColor),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Theme.of(context).accentColor)),
                        contentPadding: EdgeInsets.only(left: 10, top: 40),
                        fillColor: Colors.red,
                        labelText: "Counter Name",
                        labelStyle: Theme.of(context).textTheme.headline5.apply(color: Theme.of(context).accentColor),
                        hintStyle: Theme.of(context).textTheme.subtitle1.apply(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "SAVE",
                      style: Theme.of(context).textTheme.headline6.apply(color: Theme.of(context).primaryColorLight),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    counterProvider.setPreference(_controller.text, counterProvider.touchCounters).whenComplete(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {});
  }

  String _currentTime() {
    return formatDate(
        DateTime.now().toUtc().add(Duration(hours: 9)), [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<bool> _selections = List.generate(3, (index) => false);

    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      child: Container(
        alignment: MediaQuery.of(context).orientation == Orientation.portrait ? Alignment.center : Alignment.topCenter,
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
                if (counterProvider.startYPos < counterProvider.endYPos)
                  counterProvider.gestureDown();
                else
                  counterProvider.gestureUp();

                counterProvider.refresh();
                setState(() => {});
              },
              child: Material(
                color: Theme.of(context).secondaryHeaderColor,
                child: InkWell(
                  onTap: () {
                    counterProvider.increment();
                    if (counterProvider.vibration) {}
                    counterProvider.doAnimation();
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: TextAnimation(
                      child: Container(
                        padding: MediaQuery.of(context).orientation == Orientation.portrait
                            ? EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0)
                            : EdgeInsets.only(top: 25.0, left: 150.0, right: 150.0),
                        alignment: MediaQuery.of(context).orientation == Orientation.portrait
                            ? Alignment.center
                            : Alignment.topCenter,
                        child: AutoSizeText(
                          '${counterProvider.value}',
                          style: TextStyle(
                            color: Theme.of(context).indicatorColor,
                            fontFamily: 'Rubik',
                            fontSize: 140,
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
              padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _icons
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildIcon(map.key, counterProvider),
                    )
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0),
              child: ToggleButtons(
                children: [
                  Icon(
                    Icons.brightness_7,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.brightness_7,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.brightness_7,
                    color: Colors.white,
                  ),
                ],
                isSelected: _selections,
                onPressed: (int index) {
                  themeProvider.setThemeData = index;
                  setState(() {
                    _selections[index] = !_selections[index];
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(int index, CounterProvider counterProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              if (MediaQuery.of(context).orientation == Orientation.portrait) _saveCondition(counterProvider);
            } else
              counterProvider.getPreferenceKeys().then((x) => MediaQuery.of(context).orientation == Orientation.portrait
                  ? _loadCondition(x, counterProvider, setState)
                  : null);
          });
        },
        child: Container(
          height: 60.0,
          width: 60.0,
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
          child: Icon(
            _icons[index],
            size: 25.0,
            color: _selectedIndex == index ? Theme.of(context).primaryColor : Color(0xFFB4C1C4),
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

class _TextAnimationState extends State<TextAnimation> with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
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

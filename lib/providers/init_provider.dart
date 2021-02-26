import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';
import 'package:touch_counter_app/providers/theme_provider.dart';

List<SingleChildWidget> get providers {
  return [
    ChangeNotifierProvider<CounterProvider>.value(
      value: CounterProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>.value(
      value: ThemeProvider(),
    ),
  ];
}

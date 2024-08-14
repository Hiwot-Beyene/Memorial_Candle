
import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/views/mycandles/my_candles.dart';

class MyCandlesNavigator extends StatefulWidget {
  const MyCandlesNavigator({super.key});

  @override
  State<MyCandlesNavigator> createState() => _MyCandlesNavigatorState();
}
GlobalKey<NavigatorState> MyCandlesNavigatorKey = GlobalKey<NavigatorState>();

class _MyCandlesNavigatorState extends State<MyCandlesNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: MyCandlesNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const MyCandles(),
        );
      },
    );
  }
}

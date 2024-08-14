import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/views/create/create_candles.dart';

class CreateCandlesNavigator extends StatefulWidget {
  const CreateCandlesNavigator({super.key});

  @override
  State<CreateCandlesNavigator> createState() => _CreateCandlesNavigatorState();
}
GlobalKey<NavigatorState> CreateCandlesNavigatorKey = GlobalKey<NavigatorState>();

class _CreateCandlesNavigatorState extends State<CreateCandlesNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: CreateCandlesNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) =>  CreateCandles(),
        );
      },
    );
  }
}

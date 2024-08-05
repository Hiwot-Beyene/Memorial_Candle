import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/views/create/create_candle_popup.dart';
import 'package:lightforisrael/presentation/views/create/create_candles.dart';

class CreateCandle extends StatefulWidget {
  const CreateCandle({super.key});

  @override
  CreateCandleState createState() => CreateCandleState();
}

GlobalKey<NavigatorState> CreateCandleKey = GlobalKey<NavigatorState>();

class CreateCandleState extends State<CreateCandle> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: CreateCandleKey,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/createPopup') {
          // Show the popup dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CreatePopup();
              },
            );
          });
          return null; // Return null to prevent navigation
        }
      
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => CreateCandles(),
        );
      },
    );
  }
}

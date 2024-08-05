import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/views/create/pop.dart';
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
        if (settings.name == '/createcandles') {
          // Show the popup dialog
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CreateCandle();
              },
            );
          });
          return null; 
        }
      
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => CreateCandles(),
        );
      },
    );
  }
}

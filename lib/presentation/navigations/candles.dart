import 'package:flutter/material.dart';
import 'package:lightforisrael/data/models/memorial.dart';
import 'package:lightforisrael/presentation/views/candles/details_candle.dart';
import 'package:lightforisrael/presentation/views/candles/candles.dart';

class Candles extends StatefulWidget {
  const Candles({super.key});

  @override
  CandlesState createState() => CandlesState();
}

GlobalKey<NavigatorState> CandlesNavigatorKey = GlobalKey<NavigatorState>();

class CandlesState extends State<Candles> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: CandlesNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case "/detailsCandles":
            if (args != null) {
              final Memorial memorial = args['memorial']; // Extract Memorial object
              return MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => DetailCandlesView(memorial: memorial),
              );
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => CandlesView(),
            );

          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) => CandlesView(),
            );
        }
      },
    );
  }
}

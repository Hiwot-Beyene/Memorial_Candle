
import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/views/mycandles/my_candles.dart';
import 'package:lightforisrael/presentation/views/search/search.dart';

class SearchNavigator extends StatefulWidget {
  const SearchNavigator({super.key});

  @override
  State<SearchNavigator> createState() => _SearchNavigatorState();
}
GlobalKey<NavigatorState> SearchNavigatorKey = GlobalKey<NavigatorState>();

class _SearchNavigatorState extends State<SearchNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: SearchNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) =>  SearchPage(),
        );
      },
    );
  }
}

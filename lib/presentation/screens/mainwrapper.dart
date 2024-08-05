import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightforisrael/presentation/navigations/create_candle.dart';
import 'package:lightforisrael/presentation/navigations/candles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lightforisrael/presentation/screens/my_candles.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    CandlesNavigatorKey,
    CreateCandleKey,
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true; 
    }
  }

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
     
      print('Sign out error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(
              18, 18, 18, 1), 
        appBar: AppBar(
          title: const Text('Light For Israel'),
          backgroundColor: const Color.fromRGBO(
              18, 18, 18, 1), 
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => signUserOut(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          backgroundColor: const Color.fromRGBO(
              18, 18, 18, 1), 
          selectedItemColor:
              const Color.fromARGB(255, 53, 80, 103),
          unselectedItemColor: Colors.white, 
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.candlestick_chart),
              activeIcon: Icon(Icons.candlestick_chart),
              label: 'Candles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              activeIcon: Icon(Icons.add),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              activeIcon: Icon(Icons.favorite),
              label: 'My Candles',
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                /// First Route
                Candles(),

                /// Second Route
                CreateCandle(),
                
                // thrird route

                MyCandlesScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

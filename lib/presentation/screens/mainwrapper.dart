import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/navigations/candles.dart';
import 'package:lightforisrael/presentation/views/create/create_candles.dart';
import 'package:lightforisrael/presentation/views/mycandles/my_candles.dart';
import 'package:lightforisrael/presentation/views/search/search.dart';
import 'package:lightforisrael/presentation/widgets/confirmation_dialog.dart';
import 'package:lightforisrael/presentation/widgets/custom_drawer.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; 
  bool _isLoading = true; 

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(milliseconds: 100)); 

    setState(() {
      _isLoading = false; 
    });
  }

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex].currentState?.pop();
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoRouter.of(context).go('/login');
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  Future<void> _handleLogout() async {
    final bool? shouldLogout = await showConfirmationDialog(
      context,
      'Confirm Logout',
      'Are you sure you want to log out?',
    );

    if (shouldLogout == true) {
      await signUserOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        body: Center(
            child:
                CircularProgressIndicator()), 
      );
    }

    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
          actions: [
            IconButton(
              icon: const Icon(Icons.timer_sharp),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _handleLogout,
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            Candles(),
            SearchPage(),
            CreateCandles(),
            MyCandles(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 53, 80, 103),
            unselectedItemColor: Colors.white,
            elevation: 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.candlestick_chart),
                label: 'Candles',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'My Candles',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

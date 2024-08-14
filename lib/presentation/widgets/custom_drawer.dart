import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/screens/profile.dart';
import 'confirmation_dialog.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoRouter.of(context).go('/login');
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  void _handleLogout() async {
    final shouldLogout = await showConfirmationDialog(
      context,
      'Confirm Logout',
      'Are you sure you want to logout?',
    );

    if (shouldLogout == true) {
      
      await signUserOut();

      // Navigate to the login page
      GoRouter.of(context).go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/candle.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Light for Israel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
            title: Text('Home',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).iconTheme.color)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          if (user != null) ...[
            ListTile(
                leading: Icon(Icons.favorite,
                    color: Theme.of(context).iconTheme.color),
                title: Text('My Donates',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).iconTheme.color)),
                onTap: () {
                  GoRouter.of(context).go('/login');
                }),
            ListTile(
              leading:
                  Icon(Icons.person, color: Theme.of(context).iconTheme.color),
              title: Text('Profile',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).iconTheme.color)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
              title: Text('Logout',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).iconTheme.color)),
              onTap: () {
                // Navigator.pop(context); // Close the drawer
                _handleLogout();
              },
            ),
          ] else ...[
            ListTile(
              leading:
                  Icon(Icons.login, color: Theme.of(context).iconTheme.color),
              title: Text('Login',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).iconTheme.color)),
              onTap: () {
                GoRouter.of(context).go('/login');
              },
            ),
          ],
          ListTile(
            leading: Icon(Icons.info, color: Theme.of(context).iconTheme.color),
            title: Text('About App',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).iconTheme.color)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

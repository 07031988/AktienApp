import 'package:AktienApp/Services/auth_service.dart';
import 'package:AktienApp/Services/provider.dart';
import 'package:AktienApp/Views/NewDepotView.dart';
import 'package:AktienApp/Views/first_homeView.dart';
import 'package:AktienApp/Views/home_view.dart';
import 'package:AktienApp/pages.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Models/Depot.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeView(),
    ExplorePage(),
    PastPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    final newDepot = new Depot(null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text("Aktien und Depot App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewDepotView(depot: newDepot)));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();

                pr.show();

                Future.delayed(Duration(seconds: 2)).then((value) {
                  pr.hide().whenComplete(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FirstView()));
                  });
                });
                print(" Signed Out");
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text("Explore"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("PAST"),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

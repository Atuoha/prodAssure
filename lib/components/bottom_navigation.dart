import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../screens/about.dart';
import '../screens/home.dart';
import '../screens/scan.dart';

import '../constants/colors.dart';

class BottomNavigationComponent extends StatefulWidget {
  static const routeName = '/';
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  State<BottomNavigationComponent> createState() =>
      BottomNavigationComponentState();
}

class BottomNavigationComponentState extends State<BottomNavigationComponent> {
  var index = 0;

  final List<Widget> _pages = [
    const Home(),
    const Scan(),
    const About(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        elevation:0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const DrawerComponent(),
      extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: kBackground,
          selectedItemColor: Colors.deepOrange,
          elevation: 0,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Scan Product',
              activeIcon: Icon(Icons.search),
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: 'About App',
              activeIcon: Icon(Icons.info),
              icon: Icon(Icons.info),
            ),
          ],
        ),
        backgroundColor: kBackground,
        body: _pages[index]);
  }
}

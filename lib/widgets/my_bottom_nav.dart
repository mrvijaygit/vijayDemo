import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../utils/globals.dart';

class MyBottomNavBar extends StatelessWidget {
  final int? currentIndex;

  const MyBottomNavBar(this.currentIndex,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex!,
      type: BottomNavigationBarType.fixed,
      elevation: 15,
      selectedItemColor: Globals.primary,
      items: getBottomList(),
      onTap: (index) {
        switchPages(context, index);
      },
    );
  }

  void switchPages(BuildContext context, int _currentIndex) {
    switch (_currentIndex) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        break;
    }
  }

  List<BottomNavigationBarItem> getBottomList() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.home,
          color: Colors.black,
        ),
        label: "",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.search,
          color: Colors.black,
        ),
        label: "",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.video_library,
          color: Colors.black,
        ),
        label: "",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.heart,
          color: Colors.black,
        ),
        label: "",
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.person_alt_circle_fill,
          color: Colors.black,
        ),
        label: "",
      ),
    ];
  }
}
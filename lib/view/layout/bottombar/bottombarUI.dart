import 'package:flutter/material.dart';
import 'package:modu_flutter/main.dart';
import 'package:provider/provider.dart';

class BottomBarUI extends StatelessWidget {
  const BottomBarUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: context.watch<MainStore>().tapState,
        onTap: (i) {
          context.read<MainStore>().setTapState(i);
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'shop',
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            label: 'menu',
            icon: Icon(Icons.menu_outlined),
            activeIcon: Icon(Icons.menu),
          )
        ]);
  }
}

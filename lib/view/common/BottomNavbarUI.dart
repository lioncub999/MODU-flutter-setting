import 'package:flutter/material.dart';
import 'package:modu_flutter/main.dart';
import 'package:provider/provider.dart';

class BottomNavbarUI extends StatelessWidget {
  const BottomNavbarUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: context.watch<MainStore>().tapState,
        onTap: (i) {
          context.read<MainStore>().setTapState(i);
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: 'shop',
            icon: Icon(Icons.mode_comment_outlined),
            activeIcon: Icon(Icons.mode_comment),
          ),
          BottomNavigationBarItem(
            label: 'menu',
            icon: Icon(Icons.more_horiz_outlined),
            activeIcon: Icon(Icons.more_horiz),
          )
        ]);
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final Function(int) onTap;

  const CustomNavItem({Key? key, required this.icon, required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(icon),
    );
  }
}

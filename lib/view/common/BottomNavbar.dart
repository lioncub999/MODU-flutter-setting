import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/MainStore.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

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

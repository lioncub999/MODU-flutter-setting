import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class Subpage extends StatelessWidget {
  const Subpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<MainStore>().tapState.toString());
  }
}

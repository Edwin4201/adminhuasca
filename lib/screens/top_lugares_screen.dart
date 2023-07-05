import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:flutter/material.dart';

class TopLugaresScreen extends StatelessWidget {
  static const String routeName = '/Top';

  const TopLugaresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Lugares"),
      ),
      drawer: Navigationdrawer(),
    );
  }
}

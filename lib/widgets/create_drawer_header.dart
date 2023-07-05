import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(color: Colors.black
          // image: DecorationImage(
          //     fit: BoxFit.fill, image: AssetImage('assets/header.png')),
          ),
      child: Stack(children: <Widget>[]));
}

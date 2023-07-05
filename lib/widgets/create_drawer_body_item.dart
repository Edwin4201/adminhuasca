import 'package:flutter/material.dart';

Widget createDrawerBodyItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, color: Colors.lightGreenAccent),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 15))),
        )
      ],
    ),
    onTap: onTap,
  );
}

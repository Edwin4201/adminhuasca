import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget createDrawerBodyItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        CircleAvatar(
          child: Icon(icon, color: Colors.white),
          backgroundColor: Colors.green[400],
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text,
                  style: GoogleFonts.archivoNarrow(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15))),
        )
      ],
    ),
    onTap: onTap,
  );
}

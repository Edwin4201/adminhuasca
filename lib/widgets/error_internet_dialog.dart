import 'package:flutter/material.dart';

errorinternetdialog(
  BuildContext context,
) {
  return showDialog(
    barrierColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text("Sin conexión a internet"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}

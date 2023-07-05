import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo,
    String textoBoton, VoidCallback presionar) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width >= 600
                        ? MediaQuery.of(context).size.width * 0.04
                        : 20),
              ),
              content: Text(
                subtitulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width >= 600
                        ? MediaQuery.of(context).size.width * 0.03
                        : 18),
              ),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: presionar,
                    child: Text(
                      textoBoton,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width >= 600
                              ? MediaQuery.of(context).size.width * 0.03
                              : 16),
                    )),
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(
                titulo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width >= 600
                        ? MediaQuery.of(context).size.width * 0.04
                        : 20),
              ),
              content: Text(
                subtitulo,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width >= 600
                        ? MediaQuery.of(context).size.width * 0.03
                        : 18),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: presionar,
                  child: Text(
                    textoBoton,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width >= 600
                            ? MediaQuery.of(context).size.width * 0.03
                            : 16),
                  ),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width >= 600
                            ? MediaQuery.of(context).size.width * 0.03
                            : 16),
                  ),
                ),
              ],
            ));
  }
}

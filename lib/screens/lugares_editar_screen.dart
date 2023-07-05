import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/services/estados_service.dart';
import 'package:adminhuasca/widgets/campodetexto_ln.dart';
import 'package:adminhuasca/widgets/error_internet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../widgets/mostrar_alerta.dart';

class LugaresEditarScreen extends StatefulWidget {
  const LugaresEditarScreen({super.key});

  @override
  State<LugaresEditarScreen> createState() => _LugaresAgregarScreenState();
}

class _LugaresAgregarScreenState extends State<LugaresEditarScreen> {
  TextEditingController nombreCtrl = TextEditingController();
  bool asignado = false;
  //

  @override
  Widget build(BuildContext context) {
    final estadosService = Provider.of<EstadosService>(context);
    Map parametros = ModalRoute.of(context)!.settings.arguments as Map;
    asignado == true
        ? null
        : estadosService.isLoading
            ? null
            : setState(() {
                nombreCtrl.text = parametros["nombre"];

                asignado = true;
              });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        title: Text("Editar lugar"),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        children: [
          CampoDeTextoLn(
            largo: 79,
            controler: nombreCtrl,
            label: "NOMBRE",
            validator: (value) {
              return;
            },
          ),
          FilledButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange)),
              onPressed: () {
                mostrarAlerta(context, "¡Atención!",
                    "Desea modificar este lugar?", "Modificar", () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Future nuevoLugar() async {
                    try {
                      final response = await http.put(
                          Uri.parse(
                              '${Environment.apiUrl}/api/v1/lugar/${parametros["id"]}'),
                          body: {
                            "nombre": nombreCtrl.text.trim().toString(),
                          },
                          headers: {
                            "apikey": Environment.basicAuth
                          });

                      if (response.statusCode == 200) {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 3),
                          content: const Text('Lugar Editado'),
                          action: SnackBarAction(
                            label: "",
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacementNamed(context, "lugares");
                      } else {
                        if (response.statusCode == 401) {
                          mostrarAlerta(context, 'Registro incorrecto',
                              "El ID ya existe", "ok", () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        } else {
                          if (!mounted) return;

                          mostrarAlerta(context, 'Registro incorrecto',
                              " Introduzca los datos cerrectamente", "ok", () {
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                          return;
                        }
                      }
                    } on SocketException {
                      errorinternetdialog(
                        context,
                      );
                    }
                  }

                  nuevoLugar();
                });
              },
              icon: Icon(
                FontAwesomeIcons.upload,
                color: Colors.black,
              ),
              label: Text(
                "Actualizar",
                style: GoogleFonts.spaceGrotesk(color: Colors.black),
              )),
        ],
      ),
    );
  }
}

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

class LugaresAgregarScreen extends StatefulWidget {
  const LugaresAgregarScreen({super.key});

  @override
  State<LugaresAgregarScreen> createState() => _LugaresAgregarScreenState();
}

class _LugaresAgregarScreenState extends State<LugaresAgregarScreen> {
  final _formKey1 = GlobalKey<FormState>();

  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController estadoCtrl = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    final estadosService = Provider.of<EstadosService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Agregar nuevo lugar"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        children: [
          Form(
              key: _formKey1,
              child: Column(
                children: [
                  CampoDeTextoLn(
                    controler: idCtrl,
                    label: "ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "ID del lugar";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "solo números.";
                      }
                      if (value.contains(" ")) {
                        return "No puede contener espacios.";
                      }
                      return null;
                    },
                  ),
                  CampoDeTextoLn(
                    largo: 79,
                    controler: nombreCtrl,
                    label: "NOMBRE",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "campo obligatorio";
                      }
                      return null;
                    },
                  ), //estado
                  CampoDeTextoLn(
                    icon: PopupMenuButton(
                        onSelected: (value) {
                          setState(() {
                            if (!mounted) return;

                            estadoCtrl.text = value.toString();
                          });
                        },
                        color: Colors.white,
                        icon: const Icon(
                          FontAwesomeIcons.caretDown,
                          color: Colors.blue,
                        ),
                        itemBuilder: (context) => List.generate(
                              estadosService.estados[0].response.length,
                              (index) => PopupMenuItem(
                                  value: estadosService
                                      .estados[0].response[index].nombreEstado,
                                  child: Text(
                                      estadosService.estados[0].response[index]
                                          .nombreEstado,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >=
                                                  600
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04
                                              : 18))),
                            )),
                    isreadOnly: true,
                    controler: estadoCtrl,
                    label: "¿Seleccione su estado?",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Favor de seleccionar una opción";
                      }

                      return null;
                    },
                  ),
                ],
              )),
          FilledButton.icon(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                  mostrarAlerta(context, "¡Atención!",
                      "Desea Agregar este lugar?", "Agregar", () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Future nuevoLugar() async {
                      try {
                        final response = await http.post(
                            Uri.parse('${Environment.apiUrl}/api/v1/lugar'),
                            body: {
                              "id_lugar": idCtrl.text.trim().toString(),
                              "nombre": nombreCtrl.text.trim().toString(),
                              "id_estado": estadosService.estados[0].response
                                  .where(
                                    (element) =>
                                        element.nombreEstado ==
                                        estadoCtrl.text.trim(),
                                  )
                                  .toList()[0]
                                  .idEstado
                                  .toString(),
                              "estrellas": "0",
                              "total_comentarios": "0"
                            },
                            headers: {
                              "apikey": Environment.basicAuth
                            });

                        if (response.statusCode == 200) {
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 3),
                            content: const Text('Lugar Agregado'),
                            action: SnackBarAction(
                              label: "ID ${idCtrl.text.toString()}",
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

                            mostrarAlerta(
                                context,
                                'Registro incorrecto',
                                " Introduzca los datos cerrectamente",
                                "ok", () {
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
                }
              },
              icon: const Icon(
                FontAwesomeIcons.check,
                color: Colors.white,
              ),
              label: Text(
                "Agregar",
                style: GoogleFonts.glegoo(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

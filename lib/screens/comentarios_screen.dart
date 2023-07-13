import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/models/com_no_revisados.dart';
import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/error_internet_dialog.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ComentariosScreen extends StatefulWidget {
  static const String routeName = '/Comentarios';

  const ComentariosScreen({super.key});

  @override
  State<ComentariosScreen> createState() => _ComentariosScreenState();
}

class _ComentariosScreenState extends State<ComentariosScreen> {
  List<ComNoRevisados> comentariosNoRevisados = [];

  @override
  Widget build(BuildContext context) {
    Future<List<ComNoRevisados>> cargarComentariosNoRevisados() async {
      try {
        final url = Uri.parse(
          '${Environment.apiUrl}/api/v1/comentarios/norevisados',
        );
        final resp = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "apikey": Environment.basicAuth
          },
        );
        if (resp.statusCode == 200) {
          final ComNoRevisados estadosMap =
              ComNoRevisados.fromJson(jsonDecode(resp.body));
          if (mounted) {
            setState(() {
              comentariosNoRevisados = [estadosMap];
            });
          }
        } else {
          // La petición falló con un código de estado no exitoso
          throw Exception('Failed to load post');
        }

        return comentariosNoRevisados;
      } on TimeoutException catch (_) {
        throw ('Tiempo de espera alcanzado');
      } on SocketException {
        throw ('Sin internet  o falla de servidor ');
      } on HttpException {
        throw ("No se encontro esa peticion");
      } on FormatException {
        throw ("Formato erroneo ");
      }
    }

    cargarComentariosNoRevisados();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        title: Text(comentariosNoRevisados.isEmpty
            ? ""
            : "Por revisar: ${comentariosNoRevisados[0].total.toString()}"),
      ),
      drawer: const Navigationdrawer(),
      body: ListView(
        children: comentariosNoRevisados.isEmpty
            ? []
            : List.generate(
                comentariosNoRevisados[0].response.length,
                (index) => ComentarioItem(
                      idComentario: comentariosNoRevisados[0]
                          .response[index]
                          .idComentarios
                          .toString(),
                      idLugar: comentariosNoRevisados[0]
                          .response[index]
                          .idLugar
                          .toString(),
                      idVisita: comentariosNoRevisados[0]
                          .response[index]
                          .idVisita
                          .toString(),
                      comentario: comentariosNoRevisados[0]
                          .response[index]
                          .comentario
                          .toString(),
                      calificacion: comentariosNoRevisados[0]
                          .response[index]
                          .calificacion
                          .toString(),
                      fecha: comentariosNoRevisados[0]
                          .response[index]
                          .fecha
                          .toString(),
                      hora: comentariosNoRevisados[0]
                          .response[index]
                          .hora
                          .toString(),
                    )),
      ),
    );
  }
}

class ComentarioItem extends StatelessWidget {
  final String idComentario;
  final String idLugar;
  final String idVisita;
  final String comentario;
  final String calificacion;
  final String fecha;
  final String hora;

  const ComentarioItem({
    super.key,
    required this.idComentario,
    required this.idLugar,
    required this.idVisita,
    required this.comentario,
    required this.calificacion,
    required this.fecha,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre lugar: $idLugar",
            style: GoogleFonts.archivoNarrow(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    fecha.substring(0, 10),
                    style: GoogleFonts.archivoNarrow(color: Colors.black),
                  ),
                  Text(
                    hora,
                    style: GoogleFonts.archivoNarrow(color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: double.parse(calificacion),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black26,
            thickness: 5,
          ),
          Text(
            "ID comentario: $idComentario",
            style: GoogleFonts.archivoNarrow(color: Colors.black),
            textAlign: TextAlign.left,
          ),
          Text(
            "ID visita: $idVisita",
            style: GoogleFonts.archivoNarrow(color: Colors.black),
            textAlign: TextAlign.left,
          ),
          Text(
            comentario,
            style: GoogleFonts.archivoNarrow(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    mostrarAlerta(context, "¡Atención!",
                        "Desea rechazar este comentario?", "Aceptar", () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Future rechazarComentario() async {
                        try {
                          final response = await http.put(
                              Uri.parse(
                                  '${Environment.apiUrl}/api/v1/comentarios/norevisados/$idComentario'),
                              body: {
                                "aceptado": false.toString(),
                                "revisado": true.toString(),
                              },
                              headers: {
                                "apikey": Environment.basicAuth
                              });

                          if (response.statusCode == 200) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                              content: const Text('Comentario rechazado'),
                              action: SnackBarAction(
                                label: "",
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            //   Navigator.pushReplacementNamed(context, "lugares");
                          } else {
                            if (response.statusCode == 401) {
                              mostrarAlerta(context, 'Registro incorrecto',
                                  "El ID ya existe", "ok", () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            } else {
                              mostrarAlerta(
                                  context,
                                  'Registro incorrecto',
                                  " Introduzca los datos cerrectamente",
                                  "ok", () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
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

                      rechazarComentario();
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Rechazar",
                    style: GoogleFonts.archivoNarrow(color: Colors.white),
                  )),
              FilledButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    mostrarAlerta(context, "¡Atención!",
                        "Desea aceptar este comentario?", "Aceptar", () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Future aceptarComentario() async {
                        try {
                          final response = await http.put(
                              Uri.parse(
                                  '${Environment.apiUrl}/api/v1/comentarios/norevisados/$idComentario'),
                              body: {
                                "aceptado": true.toString(),
                                "revisado": true.toString(),
                              },
                              headers: {
                                "apikey": Environment.basicAuth
                              });

                          if (response.statusCode == 200) {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 3),
                              content: const Text('Comentario aceptado'),
                              action: SnackBarAction(
                                label: "",
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            //   Navigator.pushReplacementNamed(context, "lugares");
                          } else {
                            if (response.statusCode == 401) {
                              mostrarAlerta(context, 'Registro incorrecto',
                                  "El ID ya existe", "ok", () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            } else {
                              mostrarAlerta(
                                  context,
                                  'Registro incorrecto',
                                  " Introduzca los datos cerrectamente",
                                  "ok", () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
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

                      aceptarComentario();
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.check,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Aceptar",
                    style: GoogleFonts.archivoNarrow(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

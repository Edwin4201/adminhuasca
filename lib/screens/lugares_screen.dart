import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/models/lugares.dart';
import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:adminhuasca/widgets/error_internet_dialog.dart';
import 'package:adminhuasca/widgets/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LugaresScreen extends StatefulWidget {
  static const String routeName = '/Lugares';

  const LugaresScreen({super.key});

  @override
  State<LugaresScreen> createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  List<Lugares> lugares = [];

  @override
  Widget build(BuildContext context) {
    Future<List<Lugares>> cargarLugares() async {
      try {
        final url = Uri.parse(
          '${Environment.apiUrl}/api/v1/lugar',
        );
        final resp = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "apikey": Environment.basicAuth
          },
        );
        if (resp.statusCode == 200) {
          final Lugares estadosMap = Lugares.fromJson(jsonDecode(resp.body));
          if (mounted) {
            setState(() {
              lugares = [estadosMap];
            });
          }
        } else {
          // La petición falló con un código de estado no exitoso
          throw Exception('Failed to load post');
        }

        return lugares;
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

    cargarLugares();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          title: const Text("Gestionar lugares")),
      drawer: const Navigationdrawer(),
      body: ListView(
        children: lugares.isEmpty
            ? []
            : List.generate(
                lugares[0].response.length,
                (index) => LugarItem(
                      idLugar: lugares[0].response[index].idLugar.toString(),
                      nombre: lugares[0].response[index].nombre,
                      idEstado: lugares[0].response[index].idEstado.toString(),
                      estrellas:
                          lugares[0].response[index].estrellas.toString(),
                      totalComentarios: lugares[0]
                          .response[index]
                          .totalComentarios
                          .toString(),
                    )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mostrarAlerta(
            context,
            "¡Atención!",
            "Agregar un nuevo lugar cuidadosamente",
            "Agregar",
            () {
              Navigator.of(context, rootNavigator: true).pop();

              Navigator.pushNamed(context, "agregarlugar");
            },
          );
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class LugarItem extends StatelessWidget {
  final String idLugar;
  final String nombre;
  final String idEstado;
  final String estrellas;
  final String totalComentarios;

  const LugarItem({
    super.key,
    required this.idLugar,
    required this.nombre,
    required this.idEstado,
    required this.estrellas,
    required this.totalComentarios,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Id: ",
                style: GoogleFonts.glegoo(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                idLugar,
                style: GoogleFonts.glegoo(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Nombre: ",
                style: GoogleFonts.glegoo(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                nombre,
                style: GoogleFonts.glegoo(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Estado: ",
                style: GoogleFonts.glegoo(
                    color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                idEstado,
                style: GoogleFonts.glegoo(color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Comentarios= ",
                style: GoogleFonts.glegoo(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                totalComentarios,
                style: GoogleFonts.glegoo(color: Colors.black),
              )
            ],
          ),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: double.parse(estrellas),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  FontAwesomeIcons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Borrar", () {
                      Navigator.of(context, rootNavigator: true).pop();

                      Future borrarEjercicio() async {
                        try {
                          final response = await http.delete(
                              Uri.parse(
                                  '${Environment.apiUrl}/api/v1/lugar/$idLugar'),
                              headers: {"apikey": Environment.basicAuth});
                          if (response.statusCode == 200) {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 3),
                              content: const Text(
                                'Lugar eliminado',
                              ),
                              action: SnackBarAction(
                                label: idLugar,
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacementNamed(context, "lugares");
                          } else {
                            if (response.statusCode == 400) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 5),
                                content: const Text(
                                  "No se puede eliminar este lugar ya que tiene visitas asociadas",
                                ),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            } else {
                              // Si esta respuesta no fue OK, lanza un error.
                              throw Exception('Failed to load post');
                            }
                          }
                        } on SocketException {
                          errorinternetdialog(
                            context,
                          );
                        }
                      }

                      borrarEjercicio();
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Borrar",
                    style: GoogleFonts.glegoo(color: Colors.white),
                  )),
              FilledButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    mostrarAlerta(
                        context,
                        "¡No tocar!",
                        "Usar esta función solo para emergencias",
                        "Editar", () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushNamed(context, "editarlugar", arguments: {
                        "id": idLugar,
                        "nombre": nombre,
                        "idestado": idEstado,
                        "estrellas": estrellas,
                        "totalcomentarios": totalComentarios,
                      });
                    });
                  },
                  icon: const Icon(
                    FontAwesomeIcons.solidPenToSquare,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Editar",
                    style: GoogleFonts.glegoo(color: Colors.white),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

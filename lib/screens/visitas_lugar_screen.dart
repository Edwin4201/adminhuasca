import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/models/lugares.dart';
import 'package:adminhuasca/navigationDrawer/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class VisitasLugarScreen extends StatefulWidget {
  static const String routeName = '/VisitasLugar';

  const VisitasLugarScreen({super.key});

  @override
  State<VisitasLugarScreen> createState() => _VisitasLugarScreenState();
}

class _VisitasLugarScreenState extends State<VisitasLugarScreen> {
  List<Lugares> lugares = [];

  @override
  Widget build(BuildContext context) {
    Future<List<Lugares>> cargarLugares() async {
      try {
        final url = Uri.parse(
          '${Environment.apiUrl}/api/v1/lugar/porvisitas',
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
          if (this.mounted) {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        title: Text("Visitantes por lugar"),
      ),
      drawer: Navigationdrawer(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: lugares.isEmpty
            ? []
            : List.generate(
                lugares[0].response.length,
                (index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "visitasdetalles",
                            arguments: {
                              "idlugar": lugares[0].response[index].idLugar
                            });
                      },
                      child: _LugaresItem(
                        nombre: lugares[0].response[index].nombre,
                        calificacion:
                            lugares[0].response[index].estrellas.toString(),
                        total: lugares[0]
                            .response[index]
                            .totalComentarios
                            .toString(),
                        visitas:
                            lugares[0].response[index].totalVisitas.toString(),
                      ),
                    )),
      ),
    );
  }
}

class _LugaresItem extends StatelessWidget {
  final String nombre;
  final String calificacion;

  final String total;
  final String visitas;

  const _LugaresItem({
    super.key,
    required this.nombre,
    required this.calificacion,
    required this.total,
    required this.visitas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre,
            style: GoogleFonts.spaceGrotesk(color: Colors.green),
          ),
          Text(
            "Total de visitantes: $visitas",
            style: GoogleFonts.spaceGrotesk(color: Colors.green),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                FontAwesomeIcons.star,
                color: Colors.yellow,
              ),
              Text(
                " " + calificacion.substring(0, 3),
                style: GoogleFonts.spaceGrotesk(color: Colors.green),
              ),
              Text(
                " Total de reseñas: $total",
                style: GoogleFonts.spaceGrotesk(color: Colors.green),
              )
            ],
          ),
          Divider(
            color: Colors.lightGreenAccent,
          )
        ],
      ),
    );
  }
}

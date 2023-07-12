import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/models/com_no_revisados.dart';
import 'package:adminhuasca/models/estadisticas_visitas_model.dart';
import 'package:adminhuasca/widgets/estrellas_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class VisitasDetallesScreen extends StatefulWidget {
  const VisitasDetallesScreen({super.key});

  @override
  State<VisitasDetallesScreen> createState() => _VisitasDetallesScreenState();
}

class _VisitasDetallesScreenState extends State<VisitasDetallesScreen> {
  List<EstadisticaVisitas> estadisticas = [];
  List<ComNoRevisados> comentariosNoRevisados = [];

  @override
  Widget build(BuildContext context) {
    Map parametros = ModalRoute.of(context)!.settings.arguments as Map;
    Future<List<EstadisticaVisitas>> cargarLugares() async {
      try {
        final url = Uri.parse(
          '${Environment.apiUrl}/api/v1/visita/estadistica/${parametros["idlugar"]}',
        );
        final resp = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "apikey": Environment.basicAuth
          },
        );
        if (resp.statusCode == 200) {
          final EstadisticaVisitas estadosMap =
              EstadisticaVisitas.fromJson(jsonDecode(resp.body));
          if (this.mounted) {
            setState(() {
              estadisticas = [estadosMap];
            });
          }
        } else {
          // La petición falló con un código de estado no exitoso
          throw Exception('Failed to load post');
        }

        return estadisticas;
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
    Future<List<ComNoRevisados>> cargarComentariosNoAceptados() async {
      try {
        final url = Uri.parse(
          '${Environment.apiUrl}/api/v1/comentarios/noaceptados/${parametros["idlugar"]}',
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
          if (this.mounted) {
            setState(() {
              comentariosNoRevisados = [estadosMap];
            });
          }
        } else {
          // La petición falló con un código de estado no exitoso
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

    cargarComentariosNoAceptados();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.green,
        title: Text("Estadisticas ${parametros["idlugar"]}"),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10),
        children: estadisticas.isEmpty
            ? []
            : [
                _GraficaItem(titulo: "¿Es un lugar seguro?", data: {
                  "Si": double.parse(estadisticas[0].totalSeguros),
                  "No": double.parse(estadisticas[0].totalNoSeguros)
                }, colores: [
                  Colors.blue,
                  Colors.red
                ]),
                _GraficaItem(titulo: "¿Ha visitado este lugar antes?", data: {
                  "Si": double.parse(estadisticas[0].totalsivisitaprevia),
                  "No": double.parse(estadisticas[0].totalnovisitaprevia)
                }, colores: [
                  Colors.blue,
                  Colors.red
                ]),
                _GraficaItem(titulo: "¿Regresaria a este lugar?", data: {
                  "Si": double.parse(estadisticas[0].totalsiregresara),
                  "No": double.parse(estadisticas[0].totalnoregresara)
                }, colores: [
                  Colors.blue,
                  Colors.red
                ]),
                _GraficaItem(titulo: "Medios de transporte", data: {
                  "Auto propio": double.parse(estadisticas[0].totalautopropio),
                  "transporte público":
                      double.parse(estadisticas[0].totaltransportepublico),
                  "Autobús turístico":
                      double.parse(estadisticas[0].totalautobusturistico),
                  "Otro": double.parse(estadisticas[0].totalotro),
                }, colores: [
                  Colors.blue,
                  Colors.red,
                  Colors.green,
                  Colors.pink
                ]),
                Text(
                  "Total de reseñas ${estadisticas[0].totalresenas}",
                  style: GoogleFonts.spaceGrotesk(color: Colors.green),
                ),
                EstrellasItem(
                  icon1: FontAwesomeIcons.solidStar,
                  icon2: FontAwesomeIcons.solidStar,
                  icon3: FontAwesomeIcons.solidStar,
                  icon4: FontAwesomeIcons.solidStar,
                  icon5: FontAwesomeIcons.solidStar,
                  valor: ((double.parse(estadisticas[0].cinco)) /
                      (double.parse(estadisticas[0].totalresenas))),
                ),
                EstrellasItem(
                  icon1: FontAwesomeIcons.solidStar,
                  icon2: FontAwesomeIcons.solidStar,
                  icon3: FontAwesomeIcons.solidStar,
                  icon4: FontAwesomeIcons.solidStar,
                  icon5: FontAwesomeIcons.star,
                  valor: ((double.parse(estadisticas[0].cuatro)) /
                      (double.parse(estadisticas[0].totalresenas))),
                ),
                EstrellasItem(
                  icon1: FontAwesomeIcons.solidStar,
                  icon2: FontAwesomeIcons.solidStar,
                  icon3: FontAwesomeIcons.solidStar,
                  icon4: FontAwesomeIcons.star,
                  icon5: FontAwesomeIcons.star,
                  valor: ((double.parse(estadisticas[0].tres)) /
                      (double.parse(estadisticas[0].totalresenas))),
                ),
                EstrellasItem(
                  icon1: FontAwesomeIcons.solidStar,
                  icon2: FontAwesomeIcons.solidStar,
                  icon3: FontAwesomeIcons.star,
                  icon4: FontAwesomeIcons.star,
                  icon5: FontAwesomeIcons.star,
                  valor: ((double.parse(estadisticas[0].dos)) /
                      (double.parse(estadisticas[0].totalresenas))),
                ),
                EstrellasItem(
                  icon1: FontAwesomeIcons.solidStar,
                  icon2: FontAwesomeIcons.star,
                  icon3: FontAwesomeIcons.star,
                  icon4: FontAwesomeIcons.star,
                  icon5: FontAwesomeIcons.star,
                  valor: ((double.parse(estadisticas[0].uno)) /
                      (double.parse(estadisticas[0].totalresenas))),
                ),
                comentariosNoRevisados.isEmpty
                    ? Container()
                    : Container(
                        height: 300,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.lightGreenAccent)),
                        child: ListView(
                          children: List.generate(
                              comentariosNoRevisados[0].response.length,
                              (index) => _comentarioItem(
                                  comentario: comentariosNoRevisados[0]
                                      .response[index]
                                      .comentario,
                                  calif: comentariosNoRevisados[0]
                                      .response[index]
                                      .calificacion
                                      .toString())),
                        ),
                      )
              ],
      ),
    );
  }
}

class _comentarioItem extends StatelessWidget {
  final String comentario;
  final String calif;
  const _comentarioItem({
    super.key,
    required this.comentario,
    required this.calif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comentario,
            style: GoogleFonts.spaceGrotesk(color: Colors.green),
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.star,
                color: Colors.yellow,
              ),
              Text(
                "  $calif",
                style: GoogleFonts.spaceGrotesk(color: Colors.yellow),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

class _GraficaItem extends StatelessWidget {
  final String titulo;
  final Map<String, double> data;
  final List<Color> colores;
  const _GraficaItem({
    super.key,
    required this.titulo,
    required this.data,
    required this.colores,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.lightGreenAccent)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              titulo,
              style: GoogleFonts.spaceGrotesk(color: Colors.green),
            ),
          ),
          PieChart(
            dataMap: data,

            animationDuration: Duration(seconds: 2),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 4,
            colorList: colores,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            //  centerText: "HYBRID",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              decimalPlaces: 1,
            ),
          )
        ],
      ),
    );
  }
}

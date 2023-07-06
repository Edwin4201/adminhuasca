import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class VisitasDetallesScreen extends StatefulWidget {
  const VisitasDetallesScreen({super.key});

  @override
  State<VisitasDetallesScreen> createState() => _VisitasDetallesScreenState();
}

class _VisitasDetallesScreenState extends State<VisitasDetallesScreen> {
  @override
  Widget build(BuildContext context) {
    Map parametros = ModalRoute.of(context)!.settings.arguments as Map;

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
        children: [
          _GraficaItem(
              titulo: "¿Es un lugar seguro?",
              data: {"si": 5, "No": 3},
              colores: [Colors.blue, Colors.red]),
          _GraficaItem(
              titulo: "¿Ha visitado este lugar antes?",
              data: {"si": 7, "No": 3},
              colores: [Colors.blue, Colors.red]),
          _GraficaItem(
              titulo: "¿Regresaria a este lugar?",
              data: {"si": 8, "No": 3},
              colores: [Colors.blue, Colors.red]),
          _GraficaItem(titulo: "Medios de transporte", data: {
            "Auto propio": 10,
            "transporte público": 7,
            "Autobús turístico": 2,
            "Otro": 1
          }, colores: [
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.pink
          ])
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
              showChartValuesInPercentage: false,
              showChartValuesOutside: true,
              decimalPlaces: 1,
            ),
          )
        ],
      ),
    );
  }
}

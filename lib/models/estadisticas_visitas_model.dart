// To parse this JSON data, do
//
//     final estadisticaVisitas = estadisticaVisitasFromJson(jsonString);

import 'dart:convert';

class EstadisticaVisitas {
  final String message;
  final String totalSeguros;
  final String totalNoSeguros;
  final String totalsivisitaprevia;
  final String totalnovisitaprevia;
  final String totalsiregresara;
  final String totalnoregresara;
  final String totalautopropio;
  final String totaltransportepublico;
  final String totalautobusturistico;
  final String totalotro;
  final String uno;
  final String dos;
  final String tres;
  final String cuatro;
  final String cinco;
  final String totalresenas;

  EstadisticaVisitas({
    required this.message,
    required this.totalSeguros,
    required this.totalNoSeguros,
    required this.totalsivisitaprevia,
    required this.totalnovisitaprevia,
    required this.totalsiregresara,
    required this.totalnoregresara,
    required this.totalautopropio,
    required this.totaltransportepublico,
    required this.totalautobusturistico,
    required this.totalotro,
    required this.uno,
    required this.dos,
    required this.tres,
    required this.cuatro,
    required this.cinco,
    required this.totalresenas,
  });

  factory EstadisticaVisitas.fromRawJson(String str) =>
      EstadisticaVisitas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstadisticaVisitas.fromJson(Map<String, dynamic> json) =>
      EstadisticaVisitas(
        message: json["message"],
        totalSeguros: json["totalSeguros"] ?? "0",
        totalNoSeguros: json["totalNoSeguros"] ?? "0",
        totalsivisitaprevia: json["totalsivisitaprevia"] ?? "0",
        totalnovisitaprevia: json["totalnovisitaprevia"] ?? "0",
        totalsiregresara: json["totalsiregresara"] ?? "0",
        totalnoregresara: json["totalnoregresara"] ?? "0",
        totalautopropio: json["totalautopropio"] ?? "0",
        totaltransportepublico: json["totaltransportepublico"] ?? "0",
        totalautobusturistico: json["totalautobusturistico"] ?? "0",
        totalotro: json["totalotro"] ?? "0",
        uno: json["uno"],
        dos: json["dos"],
        tres: json["tres"],
        cuatro: json["cuatro"],
        cinco: json["cinco"],
        totalresenas: json["totalresenas"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalSeguros": totalSeguros,
        "totalNoSeguros": totalNoSeguros,
        "totalsivisitaprevia": totalsivisitaprevia,
        "totalnovisitaprevia": totalnovisitaprevia,
        "totalsiregresara": totalsiregresara,
        "totalnoregresara": totalnoregresara,
        "totalautopropio": totalautopropio,
        "totaltransportepublico": totaltransportepublico,
        "totalautobusturistico": totalautobusturistico,
        "totalotro": totalotro,
        "uno": uno,
        "dos": dos,
        "tres": tres,
        "cuatro": cuatro,
        "cinco": cinco,
        "totalresenas": totalresenas,
      };
}

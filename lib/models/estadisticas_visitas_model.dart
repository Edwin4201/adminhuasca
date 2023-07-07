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
  });

  factory EstadisticaVisitas.fromRawJson(String str) =>
      EstadisticaVisitas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstadisticaVisitas.fromJson(Map<String, dynamic> json) =>
      EstadisticaVisitas(
        message: json["message"],
        totalSeguros: json["totalSeguros"],
        totalNoSeguros: json["totalNoSeguros"],
        totalsivisitaprevia: json["totalsivisitaprevia"],
        totalnovisitaprevia: json["totalnovisitaprevia"],
        totalsiregresara: json["totalsiregresara"],
        totalnoregresara: json["totalnoregresara"],
        totalautopropio: json["totalautopropio"],
        totaltransportepublico: json["totaltransportepublico"],
        totalautobusturistico: json["totalautobusturistico"],
        totalotro: json["totalotro"],
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
      };
}

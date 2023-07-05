// To parse this JSON data, do
//
//     final comNoRevisados = comNoRevisadosFromJson(jsonString);

import 'dart:convert';

class ComNoRevisados {
  final String message;
  final int total;
  final List<Response> response;

  ComNoRevisados({
    required this.message,
    required this.total,
    required this.response,
  });

  factory ComNoRevisados.fromRawJson(String str) =>
      ComNoRevisados.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComNoRevisados.fromJson(Map<String, dynamic> json) => ComNoRevisados(
        message: json["message"],
        total: json["total"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "total": total,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  final int idComentarios;
  final int idLugar;
  final int idVisita;
  final String comentario;
  final int calificacion;
  final String fecha;
  final String hora;
  final bool aceptado;
  final bool revisado;

  Response({
    required this.idComentarios,
    required this.idLugar,
    required this.idVisita,
    required this.comentario,
    required this.calificacion,
    required this.fecha,
    required this.hora,
    required this.aceptado,
    required this.revisado,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        idComentarios: json["id_comentarios"],
        idLugar: json["id_lugar"],
        idVisita: json["id_visita"],
        comentario: json["comentario"],
        calificacion: json["calificacion"],
        fecha: json["fecha"],
        hora: json["hora"],
        aceptado: json["aceptado"],
        revisado: json["revisado"],
      );

  Map<String, dynamic> toJson() => {
        "id_comentarios": idComentarios,
        "id_lugar": idLugar,
        "id_visita": idVisita,
        "comentario": comentario,
        "calificacion": calificacion,
        "fecha": fecha,
        "hora": hora,
        "aceptado": aceptado,
        "revisado": revisado,
      };
}

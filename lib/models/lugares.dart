// To parse this JSON data, do
//
//     final lugares = lugaresFromJson(jsonString);

import 'dart:convert';

class Lugares {
  final String message;
  final int total;
  final List<Response> response;

  Lugares({
    required this.message,
    required this.total,
    required this.response,
  });

  factory Lugares.fromRawJson(String str) => Lugares.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lugares.fromJson(Map<String, dynamic> json) => Lugares(
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
  final int idLugar;
  final String nombre;
  final int idEstado;
  final int estrellas;
  final int totalComentarios;

  Response({
    required this.idLugar,
    required this.nombre,
    required this.idEstado,
    required this.estrellas,
    required this.totalComentarios,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        idLugar: json["id_lugar"],
        nombre: json["nombre"],
        idEstado: json["id_estado"],
        estrellas: json["estrellas"],
        totalComentarios: json["total_comentarios"],
      );

  Map<String, dynamic> toJson() => {
        "id_lugar": idLugar,
        "nombre": nombre,
        "id_estado": idEstado,
        "estrellas": estrellas,
        "total_comentarios": totalComentarios,
      };
}

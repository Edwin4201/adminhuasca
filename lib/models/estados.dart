// To parse this JSON data, do
//
//     final estados = estadosFromJson(jsonString);

import 'dart:convert';

class Estados {
  final String message;
  final int total;
  final List<Response> response;

  Estados({
    required this.message,
    required this.total,
    required this.response,
  });

  factory Estados.fromRawJson(String str) => Estados.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Estados.fromJson(Map<String, dynamic> json) => Estados(
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
  final int idEstado;
  final String nombreEstado;

  Response({
    required this.idEstado,
    required this.nombreEstado,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        idEstado: json["id_estado"],
        nombreEstado: json["nombre_estado"],
      );

  Map<String, dynamic> toJson() => {
        "id_estado": idEstado,
        "nombre_estado": nombreEstado,
      };
}

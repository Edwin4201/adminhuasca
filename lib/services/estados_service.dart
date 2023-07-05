import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adminhuasca/global/enviroment.dart';
import 'package:adminhuasca/models/estados.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EstadosService extends ChangeNotifier {
  List<Estados> estados = [];
  bool isLoading = true;

  EstadosService() {
    cargarEstados();
  }

  Future<List<Estados>> cargarEstados() async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse(
        '${Environment.apiUrl}/api/v1/estados',
      );
      final resp = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "apikey": Environment.basicAuth
        },
      );
      if (resp.statusCode == 200) {
        final Estados estadosMap = Estados.fromJson(jsonDecode(resp.body));
        estados = [estadosMap];

        isLoading = false;
        notifyListeners();
      } else {
        // La petición falló con un código de estado no exitoso
        throw Exception('Failed to load post');
      }

      notifyListeners();
      return estados;
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
}

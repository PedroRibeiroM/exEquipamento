import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class EquipamentosService {
  final String baseUrl = 'https://app-web-uniara-example-60f73cc06c77.herokuapp.com/equipamentos';

  Future<List<dynamic>> fetchEquipamentos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao carregar equipamentos');
      }
    } catch (e) {
      throw Exception('Erro na conexão com a API');
    }
  }

  Future<void> reservarEquipamento(int id, BuildContext context, Function setState) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$id/reservar'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Equipamento reservado com sucesso!')));
        });
      } else {
        throw Exception('Falha ao reservar equipamento');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao reservar equipamento')));
    }
  }

  Future<void> liberarEquipamento(int id, BuildContext context, Function setState) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$id/liberar'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reserva liberada com sucesso!')));
        });
      } else {
        throw Exception('Falha ao liberar reserva');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao liberar reserva')));
    }
  }
}

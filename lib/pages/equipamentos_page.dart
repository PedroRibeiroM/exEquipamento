import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/equipamentos_service.dart';

class EquipamentosPage extends StatefulWidget {
  @override
  _EquipamentosPageState createState() => _EquipamentosPageState();
}

class _EquipamentosPageState extends State<EquipamentosPage> {
  List<dynamic> equipamentos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEquipamentos();
  }

  Future<void> fetchEquipamentos() async {
    List<dynamic> data = await EquipamentosService().fetchEquipamentos();
    setState(() {
      equipamentos = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipamentos')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: equipamentos.length,
              itemBuilder: (context, index) {
                final equipamento = equipamentos[index];
                return ListTile(
                  title: Text(equipamento['nome']),
                  subtitle: Text(equipamento['disponivel']
                      ? 'Disponível'
                      : 'Retirado'),
                  trailing: equipamento['disponivel']
                      ? ElevatedButton(
                          onPressed: () {
                            EquipamentosService().reservarEquipamento(equipamento['id'], context, setState);
                          },
                          child: Text('Reservar'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            EquipamentosService().liberarEquipamento(equipamento['id'], context, setState);
                          },
                          child: Text('Liberar'),
                        ),
                );
              },
            ),
    );
  }
}

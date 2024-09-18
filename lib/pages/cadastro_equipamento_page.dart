import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroEquipamentoPage extends StatefulWidget {
  @override
  _CadastroEquipamentoPageState createState() => _CadastroEquipamentoPageState();
}

class _CadastroEquipamentoPageState extends State<CadastroEquipamentoPage> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  bool disponivel = true;

  Future<void> cadastrarEquipamento() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('https://app-web-uniara-example-60f73cc06c77.herokuapp.com/equipamentos'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "nome": nome,
            "disponivel": disponivel,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Equipamento cadastrado com sucesso!'),
          ));
          Navigator.pop(context); // Voltar à tela anterior após cadastro
        } else {
          throw Exception('Falha ao cadastrar equipamento');
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao cadastrar equipamento'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Equipamentos')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do equipamento'),
                onChanged: (value) => nome = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Disponível'),
                value: disponivel,
                onChanged: (value) {
                  setState(() {
                    disponivel = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: cadastrarEquipamento,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

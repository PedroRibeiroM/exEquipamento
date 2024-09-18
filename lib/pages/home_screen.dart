import 'package:flutter/material.dart';
import 'cadastro_equipamento_page.dart';
import 'equipamentos_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestão de Equipamentos')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Consulta de Equipamentos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EquipamentosPage()));
              },
            ),
            ListTile(
              title: Text('Cadastro de Equipamentos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroEquipamentoPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('Bem-vindo ao App de Gestão de Equipamentos')),
    );
  }
}

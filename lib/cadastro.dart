import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(TelaCadastro());
}

class TelaCadastro extends StatelessWidget {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.black, 
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 250.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                labelText: "Digite seu nome",
                labelStyle: TextStyle(color: Colors.white), 
                border: OutlineInputBorder(), 
                filled: true,
                fillColor: Colors.grey[800], 
              ),
              controller: user,
            ),
            SizedBox(height: 20), 
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                labelText: "Digite sua senha",
                labelStyle: TextStyle(color: Colors.white), 
                border: OutlineInputBorder(), 
                filled: true,
                fillColor: Colors.grey[800], 
              ),
              controller: pass,
            ),
            SizedBox(height: 20), 
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                labelText: "Confirme sua senha",
                labelStyle: TextStyle(color: Colors.white), 
                border: OutlineInputBorder(), 
                filled: true,
                fillColor: Colors.grey[800], 
              ),
              controller: conPass,
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                publicarPost(user.text, pass.text);
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }

  void publicarPost(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse('http://10.109.83.4:3000/usuarios'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username.toString(),
          'password': password.toString(),
        }),
      );

      if (response.statusCode == 200) {
        
      } else {
        
        throw Exception('Erro ao salvar o cadastro');
      }
    } catch (e) {
      
      print('Erro ao salvar o cadastro: $e');
    }
  }
}

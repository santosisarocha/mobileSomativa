import 'package:flutter/material.dart';
import 'package:flutter_application_1/cadastro.dart';
import 'package:flutter_application_1/tela2.dart';


void main() {
  runApp(MaterialApp(
    home: TelaLogin(),
  ));
}

class TelaLogin extends StatelessWidget {
  TelaLogin({Key? key}) : super(key: key);

  TextEditingController _user = TextEditingController();
  TextEditingController _passw = TextEditingController();

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
              controller: _user,
            ),
            SizedBox(height: 20), 
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                labelText: "Digite sua senha",
                labelStyle: TextStyle(color: Colors.white), 
                border: OutlineInputBorder(), 
                filled: true,
                fillColor: Colors.grey[800], 
              ),
              obscureText: true,
              obscuringCharacter: '*',
              controller: _passw,
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                if (_user.text == "isa" && _passw.text == "123") {
                  print('Login correto');
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
                  
                } else {
                  print("Login incorreto");
                }
              },
              child: Text("Entrar"),
            ),
            SizedBox(height: 10), 
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaCadastro()),
                );
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Filmes',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255, 39, 211, 182)),
        ),
      ),
      home: MoviesScreen(),
    );
  }
}

class Filme {
  final String nome;
  final String imagem;
  final String duracao;
  final String anoLancamento;
  final double nota;

  Filme({
    required this.nome,
    required this.imagem,
    required this.duracao,
    required this.anoLancamento,
    required this.nota,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      nome: json['nome'] ?? '',
      imagem: json['imagem'] ?? '',
      duracao: json['duração'] ?? '',
      anoLancamento: json['ano de lançamento'] ?? '',
      nota: json['nota'] != null ? double.parse(json['nota']) : 0.0,
    );
  }
}

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<Filme>> futureFilmes;

  @override
  void initState() {
    super.initState();
    futureFilmes = fetchFilmes();
  }

  Future<List<Filme>> fetchFilmes() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map<Filme>((json) => Filme.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os filmes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Filmes',
          style: TextStyle(color: Colors.black), // Definir a cor do texto como preto
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Filme>>(
          future: futureFilmes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Nenhum filme encontrado');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Filme filme = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      children: [
                        Image.network(
                          filme.imagem,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        ListTile(
                          title: Text(filme.nome),
                          subtitle: Row(
                            children: [
                              Text('${filme.duracao} - ${filme.anoLancamento} - '),
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: filme.nota,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

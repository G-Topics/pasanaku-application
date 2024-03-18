import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jugadores = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/jugadores'));

    if (response.statusCode == 200) {
      setState(() {
        jugadores = json.decode(response.body);
      });
    } else {
      jugadores = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Jugadores'),
      ),
      body: ListView.builder(
        itemCount: jugadores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jugadores[index]['nombre']),
            subtitle: Text(jugadores[index]['email']),
          );
        },
      ),
    );
  }
}

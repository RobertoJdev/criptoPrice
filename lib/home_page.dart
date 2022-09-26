import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class MyHomePage extends StatefulWidget {
  final String title = 'Cripto price';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> retornoDados() async {
    var url = Uri.parse('https://www.mercadobitcoin.net/api/ETH/ticker/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var retorno = utf8.decode(response.bodyBytes);
      print(retorno.toString());
      return retorno.toString();
      //return jsonDecode(retorno);
    } else {
      throw Exception('Erro ao carregar API mercado bitcoin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<String>(
          future: retornoDados(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            }
            if (snapshot.hasData) {
              return Text(
                snapshot.data.toString(),
                style: TextStyle(color: Colors.yellow),
              );

              /*
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return ListTile();
              }
            );  
            */
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
        /*
      Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(retornoDados().toString(),
                      style: TextStyle(color: Colors.yellow)),
                ],
              ),
            ),
          ),
        ],
      ), */
        );
  }
}

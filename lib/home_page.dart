import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'retorno_dados.dart';
import 'show_values.dart';

String coin = 'https://www.mercadobitcoin.net/api/ETH/ticker/';

class MyHomePage extends StatefulWidget {
  final String title = 'Cripto price';

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String coin2 = coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder<Map>(
          future: retornoDados(coin2),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar dados'));
            }
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.currency_bitcoin,
                              color: Colors.yellowAccent,
                              size: 100,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black87,
                              ),
                              onPressed: () {
                                coin2 = 'eth';
                                setState(() {
                                  build(context);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(' Etherium ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black87,
                              ),
                              onPressed: () {
                                coin2 = 'bit';
                                setState(() {
                                  build(context);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('   Bitcoin   ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black87,
                              ),
                              onPressed: () {
                                coin2 = 'dog';
                                setState(() {
                                  build(context);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('  Dogcoin  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    showValues('Última negociação', snapshot.data['last']),
                    showValues('Maior preço', snapshot.data['high']),
                    showValues('Menor preço', snapshot.data['low']),
                    showValues('Quantidade negociada', snapshot.data['vol']),
                    showValues('Maior oferta', snapshot.data['buy']),
                    showValues('Menor oferta', snapshot.data['sell']),
                    showValues('Abertura', snapshot.data['open']),
                    showValues('Data e hora', snapshot.data['date'].toString()),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

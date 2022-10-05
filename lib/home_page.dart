import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'retorno.dart';

String coin = '';

class MyHomePage extends StatefulWidget {
  final String title = 'Cripto price';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String coin = 'https://www.mercadobitcoin.net/api/ETH/ticker/';

  Future<Map> retornoDados(String coinTemp) async {
    //print(coin);

    const eth = 'https://www.mercadobitcoin.net/api/ETH/ticker/';
    const bit = 'https://www.mercadobitcoin.net/api/BTC/ticker/';
    const dog = 'https://www.mercadobitcoin.net/api/DOGE/ticker/';

    switch (coinTemp) {
      case 'eth':
        coin = eth;
        break;
      case 'bit':
        coin = bit;
        break;
      case 'dog':
        coin = dog;
        break;
      default:
        coin = eth;
    }

    print(coin);

    Uri url = Uri.parse(coin);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    json = json['ticker'];
    json = Map.castFrom(json);

    if (response.statusCode == 200) {
      print('teste');
      return json;
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
        body: FutureBuilder<Map>(
          future: retornoDados(''),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            }
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(coin,
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
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
                                retornoDados('eth');
                                setState(() {
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                retornoDados('bit');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                retornoDados('dog');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('  Dogcoin  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    mostrarTexto('Última negociação', snapshot.data['last']),
                    mostrarTexto('Maior preço', snapshot.data['high']),
                    mostrarTexto('Menor preço', snapshot.data['low']),
                    mostrarTexto('Quantidade negociada', snapshot.data['vol']),
                    mostrarTexto('Maior oferta', snapshot.data['buy']),
                    mostrarTexto('Menor oferta', snapshot.data['sell']),
                    mostrarTexto('Abertura', snapshot.data['open']),
                    mostrarTexto(
                        'Data e hora', snapshot.data['date'].toString()),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

mostrarTexto(String campo, String valor) {
  if (campo != 'Data e hora' && campo != 'Última negociação') {
    return Column(
      children: [
        Text(
          campo,
          style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 18,
              fontWeight: FontWeight.w300),
        ),
        Text(
          valor,
          style: TextStyle(
              color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  } else if (campo != 'Última negociação') {
    DateTime parsedDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(valor) * 1000);
    String fdatetime = DateFormat('d-M-y HH:mm:ss').format(parsedDate);
    return Column(
      children: [
        Text(
          campo,
          style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 18,
              fontWeight: FontWeight.w300),
        ),
        Text(
          fdatetime,
          style: TextStyle(
              color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  } else {
    double novoValor = double.parse(valor);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
          child: Column(
            children: [
              Text(
                campo,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 28,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                'R\$ ' + novoValor.toStringAsPrecision(6),
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

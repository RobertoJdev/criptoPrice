import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'retorno.dart';

class Ticker {
  Ticker(
      {this.high,
      this.low,
      this.vol,
      this.last,
      this.buy,
      this.sell,
      this.open,
      this.date});

  final String high;
  final String low;
  final String vol;
  final String last;
  final String buy;
  final String sell;
  final String open;
  final String date;

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
      high: json["high"],
      low: json["low"],
      vol: json["vol"],
      last: json["last"],
      buy: json["buy"],
      sell: json["sell"],
      open: json["open"],
      date: json["date"]);
}

class MyHomePage extends StatefulWidget {
  final String title = 'Cripto price';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map> retornoDados() async {
    var url = Uri.parse('https://www.mercadobitcoin.net/api/ETH/ticker/');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    json = json['ticker'];

    json = Map.castFrom(json);

    //final Ticker ticker = Ticker.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      //var retorno = utf8.decode(response.bodyBytes);

      print(json);
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
          future: retornoDados(),
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
    print(parsedDate);
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
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

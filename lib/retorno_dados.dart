import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_page.dart';


Future<Map> retornoDados(String coinTemp) async {
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

  Uri url = Uri.parse(coin);
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  json = json['ticker'];
  json = Map.castFrom(json);

  if (response.statusCode == 200) {
    return json;
  } else {
    throw Exception('Erro ao carregar API mercado bitcoin');
  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;

class RetornoDados2 {

   Future<String> retornoDados2() async {
    var url = Uri.parse('https://www.mercadobitcoin.net/api/ETH/ticker/');
    var response = await http.get(url);
    final json = jsonDecode(response.body);

    //final Ticker ticker = Ticker.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      var retorno = utf8.decode(response.bodyBytes);

      print(json['low']);
      return retorno;
         
    } else {
      throw Exception('Erro ao carregar API mercado bitcoin');
    }
  }
}

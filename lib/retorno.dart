import 'dart:convert';
import 'package:http/http.dart' as http;

class RetornoDados {

  Future<String> retornoDados() async {
    print('teste retorno dados');
    var url = Uri.parse('https://www.mercadobitcoin.net/api/ETH/ticker/');
    var response = await http.get(url);     

    if (response.statusCode == 200) {
      var retorno =  utf8.decode(response.bodyBytes);
      print(retorno);
      return jsonDecode(retorno);
    }else{
      print('sem retorno');
      throw Exception('Erro ao carregar API mercado bitcoin');
    }
    //final responseMap = jsonDecode(response.body);
    // }
  }
}

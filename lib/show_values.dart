import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showValues(String campo, String valor) {
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

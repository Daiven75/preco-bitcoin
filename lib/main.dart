import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: TelaPrincipal(),
    debugShowCheckedModeBanner: false,
  ));
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  String _precoBitcoin = "0";

  void _atualizaPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    print("Retorno: " + retorno.toString());
   setState(() {
     _precoBitcoin = retorno["BRL"]["buy"].toString();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(bottom: 40, top: 40),
                child: Text(
                  "R\$ " + _precoBitcoin,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Atualizar preço",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                color: Colors.deepOrangeAccent,
                onPressed: _atualizaPreco,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:jogo_boliche/screens/tela_jogo_boliche.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora de Pontuação de Boliche',
    theme: ThemeData(
      primarySwatch: Colors.brown, // Tema marrom
    ),
    home: TelaJogoBoliche(),
  ));
}

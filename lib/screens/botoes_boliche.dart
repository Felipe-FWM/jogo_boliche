import 'package:flutter/material.dart';

class BotoesBoliche extends StatelessWidget {
  final Function(int) onArremessoRegistrado;

  BotoesBoliche({required this.onArremessoRegistrado});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(11, (index) {
        return Padding(
          padding: const EdgeInsets.all(1.0), // Ajustado o espaçamento
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Cor de fundo branca
              onPrimary: Colors.black, // Texto em preto
              padding: const EdgeInsets.symmetric(
                  vertical: 4, horizontal: 8), // Ajuste de padding
              textStyle: TextStyle(fontSize: 14), // Ajuste de tamanho de fonte
            ),
            onPressed: () {
              onArremessoRegistrado(index);
            },
            child: Text(index == 10 ? 'X' : index.toString()),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';

class QuadroBoliche extends StatelessWidget {
  final int primeiroArremesso;
  final int segundoArremesso;
  final int numeroQuadro;
  final int pontuacaoTotal;
  final bool estaJogando;
  final bool exibirPontuacao;
  final bool isSpare;

  QuadroBoliche({
    required this.primeiroArremesso,
    required this.segundoArremesso,
    required this.numeroQuadro,
    required this.pontuacaoTotal,
    required this.estaJogando,
    required this.exibirPontuacao,
    required this.isSpare,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        const Color.fromARGB(255, 243, 128, 33); // Cor padrão
    if (estaJogando) {
      backgroundColor =
          Color.fromARGB(218, 0, 255, 8); // Cor quando está jogando
    }

    return Container(
      width: 130, // Reduzindo a largura
      height: 70, // Quadro quadrado
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Espaço vertical igual entre os elementos
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.5), // Ajuste para cima
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                primeiroArremesso == 10
                    ? 'X'
                    : (primeiroArremesso == 0
                        ? '-'
                        : primeiroArremesso.toString()),
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(width: 65), // Espaçamento um pouco maior
              Text(
                isSpare
                    ? '/'
                    : (segundoArremesso == 10
                        ? 'X'
                        : (segundoArremesso == 0
                            ? '-'
                            : segundoArremesso.toString())),
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2), // Ajuste para baixo
            child: exibirPontuacao
                ? Text(
                    pontuacaoTotal > 0 ? pontuacaoTotal.toString() : '',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )
                : SizedBox(height: 10), // Reduzindo o espaçamento
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'botoes_boliche.dart';
import 'package:jogo_boliche/screens/quadro_boliche.dart';

class TelaJogoBoliche extends StatefulWidget {
  @override
  _TelaJogoBolicheState createState() => _TelaJogoBolicheState();
}

class _TelaJogoBolicheState extends State<TelaJogoBoliche> {
  List<List<int?>> quadros = List.generate(10, (_) => [null, null]);

  int quadroAtual = 0;
  int arremessoAtual = 0;

  void registrarArremesso(int pinosDerrubados) {
    setState(() {
      quadros[quadroAtual][arremessoAtual] = pinosDerrubados;

      if (quadroAtual < 9) {
        if (arremessoAtual == 0 && pinosDerrubados == 10) {
          // Strike
          quadroAtual++;
          arremessoAtual = 0;
        } else if (arremessoAtual == 1 ||
            (quadros[quadroAtual][0] ?? 0) + (pinosDerrubados) == 10) {
          // Spare or second shot of frame
          quadroAtual++;
          arremessoAtual = 0;
        } else {
          arremessoAtual++;
        }
      } else {
        if (arremessoAtual == 0 && pinosDerrubados == 10) {
          // Last frame strike
          arremessoAtual++;
        } else if (arremessoAtual == 1 &&
            (quadros[9][0] ?? 0) + (pinosDerrubados) == 10) {
          // Last frame spare
          arremessoAtual++;
        } else {
          quadroAtual++;
          arremessoAtual = 0;
        }
      }
    });
  }

  int calcularPontuacaoTotal(int indiceFrame) {
    int pontuacaoTotal = 0;

    for (int i = 0; i <= indiceFrame; i++) {
      int pontos = quadros[i][0] ?? 0;
      if (quadros[i][0] == 10) {
        pontos += calcularPontuacaoStrike(i);
      } else if (quadros[i][1] != null) {
        pontos += quadros[i][1]!;
        if (pontos == 10) {
          pontos += calcularPontuacaoSpare(i);
        }
      }
      pontuacaoTotal += pontos;
    }

    return pontuacaoTotal;
  }

  int calcularPontuacaoStrike(int indiceFrame) {
    int pontos = 10;
    if (indiceFrame < 9) {
      pontos += quadros[indiceFrame + 1][0] ?? 0;
      if (quadros[indiceFrame + 1][0] == 10 && indiceFrame < 8) {
        pontos += quadros[indiceFrame + 2][0] ?? 0;
      } else {
        pontos += quadros[indiceFrame + 1][1] ?? 0;
      }
    } else {
      pontos += quadros[9][1] ?? 0;
      if (quadros[9][1] == 10) {
        pontos += quadros[9][2] ?? 0;
      }
    }
    return pontos;
  }

  int calcularPontuacaoSpare(int indiceFrame) {
    return quadros[indiceFrame + 1][0] ?? 0;
  }

  int calcularPontuacaoMaxima(int indiceFrame) {
    int pontuacaoMaxima = calcularPontuacaoTotal(indiceFrame);
    int quadroAtual = indiceFrame + 1;

    while (quadroAtual < 10) {
      pontuacaoMaxima += 30;
      quadroAtual++;
    }

    return pontuacaoMaxima;
  }

  bool isSpare(int indiceFrame) {
    return quadros[indiceFrame][0] != null &&
        (quadros[indiceFrame][0] ?? 0) + (quadros[indiceFrame][1] ?? 0) == 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF8B4513),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pontuação Atual',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${calcularPontuacaoTotal(quadroAtual - 1)}',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pontuação Máxima',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${calcularPontuacaoMaxima(quadroAtual - 1)}',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, indice) {
                  bool exibirPontuacao = false;
                  if (indice < quadroAtual ||
                      (indice == quadroAtual && arremessoAtual == 1)) {
                    exibirPontuacao = true;
                  }
                  return QuadroBoliche(
                    primeiroArremesso: quadros[indice][0] ?? 0,
                    segundoArremesso: quadros[indice][1] ?? 0,
                    numeroQuadro: indice + 1,
                    pontuacaoTotal: calcularPontuacaoTotal(indice),
                    estaJogando: indice == quadroAtual,
                    exibirPontuacao: exibirPontuacao,
                    isSpare: isSpare(indice),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            BotoesBoliche(
              onArremessoRegistrado: registrarArremesso,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/models/turmas.dart';
import 'package:kanoevaa/repositories/turma_repository.dart';

import '../login.dart';

class Turmas extends StatefulWidget {
  const Turmas({
    Key? key,
  }) : super(key: key);

  @override
  State<Turmas> createState() => _TurmasState();
}

class _TurmasState extends State<Turmas> {
  late String _nomeUsuario = '';

  late final TurmaRepository _turmaRepository;
  late final FlutterSecureStorage _secureStorage;
  List<Turma> _turmas = [];

  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    _secureStorage = FlutterSecureStorage();
    _turmaRepository = TurmaRepository();
    _loadNomeUsuario();
    mensalidadeAtrasada();
    _loadTurmas();
    Future.delayed(Duration.zero, () {
      animator();
      setState(() {});
    });
  }

  Future<void> _loadNomeUsuario() async {
    try {
      String? nome = await _secureStorage.read(key: 'nomeUser');
      if (nome != null) {
        setState(() {
          _nomeUsuario = nome;
        });
      }
    } catch (error) {
      print('Erro ao carregar nome do usuário: $error');
    }
  }

  Future<String?> mensalidadeAtrasada() async {
    String? value = await _secureStorage.read(key: "mensalidade_atrasada");
    return value;
  }

  Future<void> _loadTurmas() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      if (token != null) {
        final turmas = await _turmaRepository.buscarTurmas(token);
        setState(() {
          _turmas = turmas;
        });
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (error) {
      print('Erro ao carregar turmas: $error');
    }
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: mensalidadeAtrasada(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Se ainda estiver carregando, exiba um indicador de carregamento
            return _buildLoading();
          } else if (snapshot.hasError) {
            // Se ocorrer um erro, exiba uma mensagem de erro
            return Center(
                child: Text('Erro ao carregar atrasos: ${snapshot.error}'));
          } else {
            // Caso contrário, verifique o valor retornado
            final mensalidadeAtrasada = int.tryParse(snapshot.data ?? '0') ?? 0;
            if (mensalidadeAtrasada == 0) {
              // Se não houver mensalidades atrasadas, exiba a lista de turmas
              return _buildTurmaList();
            } else {
              // Se houver mensalidades atrasadas, exiba o widget correspondente
              return _mensalidadeAtraso();
            }
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _mensalidadeAtraso() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 100,
              right: 20,
              left: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.7),
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          _nomeUsuario.isNotEmpty ? _nomeUsuario : 'Olá!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.7),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () async {
                        await _secureStorage.delete(key: 'token');
                        await _secureStorage.delete(key: 'aluno');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              top: 80,
              right: 10,
              left: 20,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade900,
                              Colors.blue.shade900,
                            ])),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Image(
                                    width: 70,
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/icons/cancel.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Entre em contato!',
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mensalidade(s) em atraso!',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
                top: 200,
                left: 30,
                right: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: opacity,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Prezado(a) aluno(a),',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Identificamos que há débitos em aberto em sua conta. É importante resolver essa questão para garantir o acesso contínuo aos serviços.',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Por favor, entre em contato conosco o mais breve possível para regularizar a situação.',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTurmaList() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 100,
              right: 20,
              left: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.7),
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          _nomeUsuario.isNotEmpty ? _nomeUsuario : 'Olá!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.7),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () async {
                        await _secureStorage.delete(key: 'token');
                        await _secureStorage.delete(key: 'aluno');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              top: 80,
              right: 10,
              left: 20,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade900,
                              Colors.blue.shade900,
                            ])),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Image(
                                    width: 70,
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/icons/check.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Obrigado!',
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mensalidades em dia!',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
                top: 200,
                left: 30,
                right: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: opacity,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Turmas Disponíveis do dia:',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.8),
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica',
                              color: Colors.blue.shade600.withOpacity(.8),
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
              top: 240,
              left: 10,
              right: 20,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    height: 370,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: _turmas.length,
                      itemBuilder: (BuildContext context, int index) {
                        final turma = _turmas[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         Agendamento(idTurma: turma),
                            //   ),
                            // );
                          },
                          child: Container(
                            width: 358,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  turma.nome,
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Data: ${turma.data}, Hora: ${turma.hora}',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Vagas: ${turma.vagasDisponiveis}',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

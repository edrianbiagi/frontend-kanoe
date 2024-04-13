import 'dart:async';

import 'package:auth_screen/model/turmas.dart';
import 'package:auth_screen/pages/agendamento.dart';
import 'package:auth_screen/repositories/turma_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class Turmas extends StatefulWidget {
  const Turmas({Key? key}) : super(key: key);

  @override
  State<Turmas> createState() => _TurmasState();
}

class _TurmasState extends State<Turmas> {
  late final TurmaRepository _turmaRepository;
  late final FlutterSecureStorage _secureStorage;
  List<Turma> _turmas = [];

  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    _secureStorage = FlutterSecureStorage();
    _turmaRepository = TurmaRepository(
      baseUrl: 'http://localhost:3000/api',
    ); // Inicializando o repositório aqui
    _loadTurmas();
    Future.delayed(Duration.zero, () {
      animator();
      setState(() {});
    });
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
      body: _turmas != null ? _buildTurmaList() : _buildLoading(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
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
                          'Edrian',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                            color: Colors.black.withOpacity(.7),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.phonelink_ring)
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
                          'Turmas Disponíveis',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Agendamento(idTurma: turma.id),
                              ),
                            );
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
                                  'Data: ${DateFormat('dd/MM/yyyy').format(turma.data)}, Hora: ${turma.hora}',
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

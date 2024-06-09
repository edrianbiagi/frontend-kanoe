import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kanoevaa/models/alunos.dart';
import 'package:kanoevaa/pages/Oppointment.dart';
import 'package:kanoevaa/pages/admin/components/custom_bar.dart';

class PerfilAlunoPage extends StatefulWidget {
  final AlunoModel aluno;

  const PerfilAlunoPage({
    Key? key,
    required this.aluno,
  }) : super(key: key);

  @override
  State<PerfilAlunoPage> createState() => _PerfilAlunoPage();
}

class _PerfilAlunoPage extends State<PerfilAlunoPage> {
  var animate = false;
  var opacity = 0.0;
  late Size size;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
    }
    setState(() {});
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomBar(title: 'Perfil do Aluno'),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_today),
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_3),
            label: 'Alunos',
          ),
          NavigationDestination(
            icon: Icon(Icons.money),
            label: 'Financeiro',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.aluno.user.nome,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.aluno.user.email,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.6),
                  fontSize: 15,
                ),
              ),
              Text(
                'Telefone: ${widget.aluno.user.telefone}',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.6),
                  fontSize: 15,
                ),
              ),
              Text(
                'CPF: ${widget.aluno.user.cpf}',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.6),
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Icon(
                          Icons.money,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    // Utilizando Expanded para evitar overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pagamentos",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.5),
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.aluno.mensalidadesEmAtraso == 0
                              ? 'Mensalidades em dia'
                              : "${widget.aluno.mensalidadesEmAtraso} parcela(s) em atraso",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    // Utilizando Expanded para evitar overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dia de Pagamento",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.5),
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.aluno.diaVencimento.toString(),
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Icon(
                          Icons.money_off_sharp,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    // Utilizando Expanded para evitar overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Valor da Mensalidade",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.5),
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'R\$ ${widget.aluno.valorMensalidade.toString()}',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informações Gerais",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Dt. Nascimento: ${widget.aluno.dtNascimento} - Profissão: ${widget.aluno.profissao}, Num. Emergência: ${widget.aluno.numEmergencia} - Contato de Emergência: ${widget.aluno.nomeEmergencia} -  Dt. de Início na Kanoê: ${widget.aluno.dtInicio} -  Obs. Patológicas: ${widget.aluno.obsPatologica} - Plano de Saúde: ${widget.aluno.planoSaude} - Tratamento médico: ${widget.aluno.tratamentoMedico} - Obs. Gerais: ${widget.aluno.obsGerais}",
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.5),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

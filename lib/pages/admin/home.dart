import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/constants.dart';
import 'package:kanoevaa/models/alunos.dart';
import 'package:kanoevaa/pages/Oppointment.dart';
import 'package:kanoevaa/pages/admin/components/custom_bar.dart';
import 'package:kanoevaa/pages/admin/components/bottom_sheet_turma.dart';
import 'package:kanoevaa/pages/admin/perfil_aluno.dart';
import 'package:kanoevaa/pages/alunos/Profile.dart';
import 'package:kanoevaa/repositories/aluno_repository.dart';

class InicialPageAdmin extends StatelessWidget {
  const InicialPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late final FlutterSecureStorage _secureStorage;
  late Future<List<AlunoModel>> _alunosFuture;
  final AlunoRepository _alunoRepository = AlunoRepository();

  @override
  void initState() {
    super.initState();
    _secureStorage = FlutterSecureStorage();
    _alunosFuture = _fetchAlunos();
  }

  Future<List<AlunoModel>> _fetchAlunos() async {
    String? token = await _secureStorage.read(key: 'token');
    return _alunoRepository.buscaAlunos(token!);
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomBar(title: 'Agenda de Aulas'),
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
      body: <Widget>[
        // Agenda
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Criar nova turma",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      BottomSheetTurma.show(context, _secureStorage);
                    },
                    child: Text(
                      "Criar",
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider()
          ],
        ),

        // Alunos
        _buildAlunosWidget(),

        // Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }

  Widget _buildAlunosWidget() {
    return FutureBuilder<List<AlunoModel>>(
      future: _alunosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Nenhum aluno encontrado'),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 16.0, left: 10, right: 10),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final aluno = snapshot.data![index];

                Color borderColor = aluno.mensalidadesEmAtraso > 0
                    ? Colors.red
                    : Color.fromARGB(255, 120, 172, 122);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PerfilAlunoPage(aluno: aluno),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: borderColor,
                        width: 2.0,
                      ),
                    ),
                    child: ListTile(
                      title: Text(aluno.user.nome),
                      subtitle: Text(aluno.dtNascimento),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

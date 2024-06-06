import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:kanoevaa/models/turmas.dart';
import 'package:kanoevaa/repositories/turma_repository.dart';

class BottomSheetTurma {
  static void show(BuildContext context, FlutterSecureStorage secureStorage) {
    TextEditingController tituloController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    TextEditingController horaController = TextEditingController();
    TextEditingController vagasController = TextEditingController();

    TurmaRepository turmaRepository = TurmaRepository();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(labelText: 'Título da Turma'),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      dataController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                    }
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(labelText: 'Data da Aula'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      horaController.text = pickedTime.format(context);
                    }
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: horaController,
                      decoration: InputDecoration(labelText: 'Hora de Início'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: vagasController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(labelText: 'Vagas Disponíveis'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número de vagas';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () async {
                      String titulo = tituloController.text;
                      String data = dataController.text;
                      String hora = horaController.text;
                      int vagas = int.parse(vagasController.text);

                      Turma novaTurma = Turma(
                        nome: titulo,
                        data: data,
                        hora: hora,
                        vagasDisponiveis: vagas,
                      );

                      try {
                        String? token = await secureStorage.read(key: 'token');

                        bool success =
                            await turmaRepository.addTurma(token, novaTurma);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Turma criada com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao criar turma'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao criar turma: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text('Criar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

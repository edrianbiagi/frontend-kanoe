import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  String? idTurma;

  @observable
  String? alunoId;

  @action
  void updateAlunoId(String id) {
    alunoId = id;
  }

  @action
  void updateIdTurma(String id) {
    idTurma = id;
  }

  @observable
  ObservableList<Map<String, dynamic>> convidado =
      ObservableList<Map<String, dynamic>>();

  @action
  void addConvidado(String nome, String idConvidado) {
    convidado.add({'nome': nome, 'id': idConvidado});
  }

  @action
  void removeConvidado(String nome) {
    convidado.remove(nome);
  }
}

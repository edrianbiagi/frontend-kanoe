import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  String alunoId = ''; 

  @observable
  String errorMessage = ''; 

  @observable
  int? statusCode; 

  @action
  updateStatusCode(value) => statusCode = value;

  @action
  updateErrorMessage(value) => errorMessage = value;

  @action
  updateAlunoId(value) => alunoId = value;

  @observable
  ObservableList<Map<String, dynamic>> convidado = ObservableList<Map<String, dynamic>>();

  @action
  void addConvidado(String nome, String idConvidado) {
    convidado.add({'nome': nome, 'id': idConvidado});
  }

  @action
  void removeConvidado(String idConvidado) {
    convidado.removeWhere((convidado) => convidado['id'] == idConvidado);
  }
}

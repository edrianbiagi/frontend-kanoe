import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  ObservableList<String> convidado = ObservableList<String>();

  @action
  void addConvidado(String nome) {
    convidado.add(nome);
  }

  @action
  void removeConvidado(String nome) {
    convidado.remove(nome);
  }
}

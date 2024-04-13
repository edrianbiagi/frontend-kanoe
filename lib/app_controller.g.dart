// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on _AppControllerBase, Store {
  late final _$convidadoAtom =
      Atom(name: '_AppControllerBase.convidado', context: context);

  @override
  ObservableList<String> get convidado {
    _$convidadoAtom.reportRead();
    return super.convidado;
  }

  @override
  set convidado(ObservableList<String> value) {
    _$convidadoAtom.reportWrite(value, super.convidado, () {
      super.convidado = value;
    });
  }

  late final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase', context: context);

  @override
  void addConvidado(String nome) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.addConvidado');
    try {
      return super.addConvidado(nome);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeConvidado(String nome) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.removeConvidado');
    try {
      return super.removeConvidado(nome);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
convidado: ${convidado}
    ''';
  }
}

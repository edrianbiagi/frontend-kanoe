// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on _AppControllerBase, Store {
  late final _$idTurmaAtom =
      Atom(name: '_AppControllerBase.idTurma', context: context);

  @override
  String get idTurma {
    _$idTurmaAtom.reportRead();
    return super.idTurma;
  }

  @override
  set idTurma(String value) {
    _$idTurmaAtom.reportWrite(value, super.idTurma, () {
      super.idTurma = value;
    });
  }

  late final _$alunoIdAtom =
      Atom(name: '_AppControllerBase.alunoId', context: context);

  @override
  String get alunoId {
    _$alunoIdAtom.reportRead();
    return super.alunoId;
  }

  @override
  set alunoId(String value) {
    _$alunoIdAtom.reportWrite(value, super.alunoId, () {
      super.alunoId = value;
    });
  }

  late final _$convidadoAtom =
      Atom(name: '_AppControllerBase.convidado', context: context);

  @override
  ObservableList<Map<String, dynamic>> get convidado {
    _$convidadoAtom.reportRead();
    return super.convidado;
  }

  @override
  set convidado(ObservableList<Map<String, dynamic>> value) {
    _$convidadoAtom.reportWrite(value, super.convidado, () {
      super.convidado = value;
    });
  }

  late final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase', context: context);

  @override
  void updateAlunoId(String id) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.updateAlunoId');
    try {
      return super.updateAlunoId(id);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateIdTurma(String id) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.updateIdTurma');
    try {
      return super.updateIdTurma(id);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addConvidado(String nome, int idConvidado) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.addConvidado');
    try {
      return super.addConvidado(nome, idConvidado);
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
idTurma: ${idTurma},
alunoId: ${alunoId},
convidado: ${convidado}
    ''';
  }
}

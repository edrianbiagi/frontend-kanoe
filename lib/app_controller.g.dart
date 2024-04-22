// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on _AppControllerBase, Store {
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

  late final _$errorMessageAtom =
      Atom(name: '_AppControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$statusCodeAtom =
      Atom(name: '_AppControllerBase.statusCode', context: context);

  @override
  int? get statusCode {
    _$statusCodeAtom.reportRead();
    return super.statusCode;
  }

  @override
  set statusCode(int? value) {
    _$statusCodeAtom.reportWrite(value, super.statusCode, () {
      super.statusCode = value;
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
  dynamic updateStatusCode(dynamic value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.updateStatusCode');
    try {
      return super.updateStatusCode(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateErrorMessage(dynamic value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.updateErrorMessage');
    try {
      return super.updateErrorMessage(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateAlunoId(dynamic value) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.updateAlunoId');
    try {
      return super.updateAlunoId(value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addConvidado(String nome, String idConvidado) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.addConvidado');
    try {
      return super.addConvidado(nome, idConvidado);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeConvidado(String idConvidado) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.removeConvidado');
    try {
      return super.removeConvidado(idConvidado);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
alunoId: ${alunoId},
errorMessage: ${errorMessage},
statusCode: ${statusCode},
convidado: ${convidado}
    ''';
  }
}

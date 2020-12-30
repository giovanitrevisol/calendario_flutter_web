// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendario_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarioController on _CalendarioControllerBase, Store {
  final _$listWeekShowAtom =
      Atom(name: '_CalendarioControllerBase.listWeekShow');

  @override
  List<Dia> get listWeekShow {
    _$listWeekShowAtom.reportRead();
    return super.listWeekShow;
  }

  @override
  set listWeekShow(List<Dia> value) {
    _$listWeekShowAtom.reportWrite(value, super.listWeekShow, () {
      super.listWeekShow = value;
    });
  }

  final _$diaShowAtom = Atom(name: '_CalendarioControllerBase.diaShow');

  @override
  Dia get diaShow {
    _$diaShowAtom.reportRead();
    return super.diaShow;
  }

  @override
  set diaShow(Dia value) {
    _$diaShowAtom.reportWrite(value, super.diaShow, () {
      super.diaShow = value;
    });
  }

  final _$appStateAtom = Atom(name: '_CalendarioControllerBase.appState');

  @override
  AppState get appState {
    _$appStateAtom.reportRead();
    return super.appState;
  }

  @override
  set appState(AppState value) {
    _$appStateAtom.reportWrite(value, super.appState, () {
      super.appState = value;
    });
  }

  final _$pageStateAtom = Atom(name: '_CalendarioControllerBase.pageState');

  @override
  PageState get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(PageState value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  final _$_CalendarioControllerBaseActionController =
      ActionController(name: '_CalendarioControllerBase');

  @override
  dynamic changeState(dynamic value) {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.changeState');
    try {
      return super.changeState(value);
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePageState(dynamic value) {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.changePageState');
    try {
      return super.changePageState(value);
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic proximaSemana() {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.proximaSemana');
    try {
      return super.proximaSemana();
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic anteriorSemana() {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.anteriorSemana');
    try {
      return super.anteriorSemana();
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic anteriorDia() {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.anteriorDia');
    try {
      return super.anteriorDia();
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic proximoDia() {
    final _$actionInfo = _$_CalendarioControllerBaseActionController
        .startAction(name: '_CalendarioControllerBase.proximoDia');
    try {
      return super.proximoDia();
    } finally {
      _$_CalendarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listWeekShow: ${listWeekShow},
diaShow: ${diaShow},
appState: ${appState},
pageState: ${pageState}
    ''';
  }
}

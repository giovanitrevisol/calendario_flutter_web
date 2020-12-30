enum AppStateEnum {
  IDLE,
  LOADING,
  FAIL,
  SUCCESS,
  WARNING,
}

extension on AppStateEnum {
  static Map<AppStateEnum, String> get names => {
        AppStateEnum.IDLE: 'IDLE',
        AppStateEnum.LOADING: 'LOADING',
        AppStateEnum.FAIL: 'FAIL',
        AppStateEnum.SUCCESS: 'SUCCESS',
        AppStateEnum.WARNING: 'WARNING',
      };

  String get name => names[this];
}

class AppState {
  final AppStateEnum type;
  final String message;

  AppState({this.type, this.message});

  @override
  String toString() {
    return this.type.name;
  }
}

class AppIdleState extends AppState {
  AppIdleState() : super(type: AppStateEnum.IDLE);
}

class AppLoadingState extends AppState {
  AppLoadingState() : super(type: AppStateEnum.LOADING);
}

class AppFailState extends AppState {
  AppFailState({String message})
      : super(type: AppStateEnum.FAIL, message: message);
}

class AppSucessState extends AppState {
  AppSucessState() : super(type: AppStateEnum.SUCCESS);
}

class AppWarningState extends AppState {
  AppWarningState() : super(type: AppStateEnum.WARNING);
}

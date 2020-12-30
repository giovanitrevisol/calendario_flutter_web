import 'package:calendario/constantes/DateUtils.dart';
import 'package:calendario/screen/controller/calendario_controller.dart';
import 'package:calendario/screen/screen/calendario_day_screen.dart';
import 'package:calendario/screen/screen/calendario_month.dart';
import 'package:calendario/screen/screen/calendario_week_screen.dart';
import 'package:calendario/screen/state_app/app_state.dart';
import 'package:calendario/screen/state_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CalendarioScreen extends StatefulWidget {
  final double height;
  final double width;
  final Color background;

  const CalendarioScreen({
    Key key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.background = Colors.white,
  }) : super(key: key);
  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateUtils dataUtil = DateUtils();
  CalendarioController calendController;
  ReactionDisposer _dispose;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calendController = Provider.of<CalendarioController>(context);
    calendController.init();
    calendController.changePageState(PageMonthState());
    _dispose = reaction((_) => calendController.appState, onAppState);
  }

  void onAppState(AppState state) {
    if (state == null) return;
    //add os demais states quando necessario
  }

  @override
  void dispose() {
    super.dispose();
    _dispose.reaction.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendController = Provider.of<CalendarioController>(context);
    return Container(
      child: Observer(builder: (_) {
        //print(calendController.appState.type);
        if (calendController.appState.type == AppStateEnum.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            height: widget.height,
            width: widget.width,
            color: widget.background,
            child: _buildComponent(calendController),
          );
        }
      }),
    );
  }

  _buildComponent(calendController) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _rowNavegacao(context, constraints, calendController),
              Observer(builder: (_) {
                switch (calendController.pageState.type) {
                  case PageStateEnum.WEEK:
                    return calendarWeek(context, constraints);
                    break;
                  case PageStateEnum.DAY:
                    return calendarDay(context, constraints);
                    break;
                  case PageStateEnum.MONTH:
                  default:
                    return calendario(context, constraints);
                }
              })
            ],
          ),
        );
      },
    );
  }

  _rowNavegacao(context, constraints, CalendarioController calendController) {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (calendController.pageState.type == PageStateEnum.MONTH)
                Expanded(
                  child: Row(
                    children: [
                      OutlineButton(
                        onPressed: () {
                          calendController.changeState(AppLoadingState());
                          calendController.init();
                          calendController.changeState(AppIdleState());
                        },
                        textColor: Colors.green,
                        borderSide: BorderSide(
                          width: 3,
                          color: Colors.green,
                        ),
                        child: Text('Hoje'),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          calendController.changeState(AppLoadingState());
                          calendController.anteriorMes();
                          calendController.changeState(AppIdleState());
                        },
                      ),
                      Text(
                        calendController.mesExibeExtenso,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          calendController.changeState(AppLoadingState());
                          calendController.proximoMes();
                          calendController.changeState(AppIdleState());
                        },
                      ),
                    ],
                  ),
                ),
              if (calendController.pageState.type == PageStateEnum.WEEK)
                Expanded(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          OutlineButton(
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.init();
                              calendController.changeState(AppIdleState());
                            },
                            textColor: Colors.green,
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.green,
                            ),
                            child: Text('Hoje'),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.anteriorSemana();
                              calendController.changeState(AppIdleState());
                            },
                          ),
                          Text(
                            calendController.semanaExibida(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.proximaSemana();
                              calendController.changeState(AppIdleState());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (calendController.pageState.type == PageStateEnum.DAY)
                Expanded(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          OutlineButton(
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.init();
                              calendController.changeState(AppIdleState());
                            },
                            textColor: Colors.green,
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.green,
                            ),
                            child: Text('Hoje'),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.anteriorDia();
                              calendController.changeState(AppIdleState());
                            },
                          ),
                          Text(
                            calendController.diaShowLong(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              calendController.changeState(AppLoadingState());
                              calendController.proximoDia();
                              calendController.changeState(AppIdleState());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Text(
                  //'${dataUtil.todayDate} - ${dataUtil.todayWeek}',
                  '${dataUtil.todayDateLong} - ${dataUtil.todayWeek}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      elevation: 0,
                      color: Colors.green,
                      textColor: Colors.green,
                      onPressed: () {
                        calendController.changePageState(PageMonthState());
                      },
                      child: Text('Mês', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    RaisedButton(
                      elevation: 0,
                      color: Colors.green,
                      textColor: Colors.green,
                      onPressed: () {
                        calendController.changePageState(PageWeekState());
                      },
                      child:
                          Text('Semana', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    RaisedButton(
                      elevation: 0,
                      color: Colors.green,
                      textColor: Colors.green,
                      onPressed: () {
                        calendController.changePageState(PageDayState());
                      },
                      child: Text('Dia', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

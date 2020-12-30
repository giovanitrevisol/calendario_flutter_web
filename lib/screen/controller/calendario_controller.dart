import 'package:calendario/constantes/DateUtils.dart';
import 'package:calendario/dommy/events_dummy.dart';
import 'package:calendario/model/dia.dart';
import 'package:calendario/model/evento.dart';
import 'package:calendario/screen/state_app/app_state.dart';
import 'package:calendario/screen/state_app/page_state.dart';

import 'package:mobx/mobx.dart';
part 'calendario_controller.g.dart';

class CalendarioController = _CalendarioControllerBase
    with _$CalendarioController;

abstract class _CalendarioControllerBase with Store {
  Dia daySelected;
  List<Dia> dias;
  List<Dia> seqDiasSemana = [];
  List<Dia> seqDiasSemanaTotal = [];
  DateUtils dateUtil = DateUtils();
  int monthShow;
  int yearShow;
  String mesExibeExtenso;

  //senama
  DateTime dayWeek;
  @observable
  List<Dia> listWeekShow = [];

  //
  @observable
  Dia diaShow;

  DateTime dia;
  //
  //

//cria uma copia da lista de eventos
  var listaEventos = {...listaEvents};

  @observable
  AppState appState = AppLoadingState();

  @action
  changeState(value) => appState = value;

  @observable
  PageState pageState;

  @action
  changePageState(value) => pageState = value;

  init() async {
    resetValues();
    this.montaDias(this.dateUtil.dayNow.month, this.dateUtil.dayNow.year);
    this.listaCompletaDias();
    mesExibeExtenso = this.dateUtil.month(dateUtil.monthCorrent);
    monthShow = dateUtil.dayNow.month;
    yearShow = dateUtil.dayNow.year;
    dayWeek = DateUtils().dayNow;
    listWeekShow = showWeekCalendar(dateUtil.dayNow);
    diaShow = Dia(dateUtil.dayNow.day, dateUtil.dayNow.month,
        dateUtil.dayNow.year, dateUtil.dayNow.weekday);
    dia = dateUtil.dayNow;

    await Future.delayed(Duration(seconds: 1));
    changeState(AppIdleState());
  }

//se mes for maior que 12 - seta 1 e add 1 ano
  validaMesAno() {
    if (monthShow > 12) {
      monthShow = 1;
      yearShow++;
      print('$monthShow  __ $yearShow');
    }
  }

//se mes for 1 - seta 12 e remove 1 ano
  validaAno() {
    if (monthShow < 1) {
      monthShow = 12;
      yearShow--;
      print('$monthShow  __ $yearShow');
    }
  }

  proximoMes() {
    resetValues();
    this.monthShow++;
    validaMesAno();
    this.montaDias(this.monthShow, yearShow);
    this.listaCompletaDias();
    mesExibeExtenso = this.dateUtil.month(monthShow);
  }

  anteriorMes() {
    resetValues();
    this.monthShow--;
    validaAno();
    this.montaDias(this.monthShow, yearShow);
    this.listaCompletaDias();
    mesExibeExtenso = this.dateUtil.month(monthShow);
  }

  resetValues() {
    seqDiasSemana = [];
    seqDiasSemanaTotal = [];
  }

  //retorna diaAtual
  Dia todayFn() {
    Dia today;
    today.dia = dateUtil.todayCurrent;
    today.mes = dateUtil.monthCorrent;
    today.ano = dateUtil.yearCorrent;
    return today;
  }

  ///retorna o dia da semana que começa o mes
  diaIniciaMes(int mes, int ano) {
    var dia1 = DateTime(ano, mes, 1);
    return dia1.weekday;
  }

  ///retorna o dia da semana - D S T Q Q S S
  dayOfWeek(int dia, int mes, int ano) {
    var dayResult = DateTime(ano, mes, dia);
    return dayResult.weekday;
  }

  ///dia da semana que começa o mes
  dayStartMonth(int mes, int ano) {
    var dayResult = DateTime(ano, mes, 1);
    return dayResult.weekday;
  }

  ///build lista de dias do mes
  montaDias(int mes, int ano) {
    var diames = dateUtil.daysInMonth(mes, ano);
    for (var dia = 1; dia <= diames; dia++) {
      seqDiasSemana.add(
        new Dia(dia, mes, ano, dayOfWeek(dia, mes, ano)),
      );
    }
  }

  ///build 42 posições do calendario
  listaCompletaDias() {
    if (seqDiasSemana != null && seqDiasSemana.isNotEmpty) {
      if (seqDiasSemana[0].diaSemana != 7) {
        for (var i = seqDiasSemana.first.diaSemana; i >= 1; i--) {
          seqDiasSemanaTotal.add(new Dia(0, 0, 0, 0));
        }
      }
      seqDiasSemanaTotal.addAll(seqDiasSemana);

      if (seqDiasSemana.last.diaSemana != 6) {
        for (var i = seqDiasSemana.last.diaSemana; i < 6; i++) {
          seqDiasSemanaTotal.add(new Dia(0, 0, 0, 0));
        }
      }
      if (seqDiasSemana.last.diaSemana == 7) {
        for (var i = 0; i < 6; i++) {
          seqDiasSemanaTotal.add(new Dia(0, 0, 0, 0));
        }
      }
    }
  }

  // semana
  weekCalendar(DateTime now) {
    //var now = dateUtil.dayNow;
    List<DateTime> listSemana = [];
    var dayEditS = now;
    var dayEditA = now;

    if (now.weekday != 7) {
      for (var i = now.weekday; i >= 1; i--) {
        dayEditS = dayEditS.subtract(Duration(days: 1));
        listSemana.add(dayEditS);
      }
    }

    listSemana.add(now);

    if (now.weekday == 7) {
      for (var i = 1; i <= 6; i++) {
        dayEditA = dayEditA.add(Duration(days: 1));
        listSemana.add(dayEditA);
      }
    } else {
      for (var i = now.weekday; i <= 5; i++) {
        dayEditA = dayEditA.add(Duration(days: 1));
        listSemana.add(dayEditA);
      }
    }

    listSemana.sort((a, b) => a.compareTo(b));

    if (listSemana.first.weekday == 7 && listSemana.last.weekday == 7) {
      listSemana.remove(listSemana.last);
    }
    return listSemana;
  }

  showWeekCalendar(DateTime dayNow) {
    var lista = [];
    lista = weekCalendar(dayNow);
    listWeekShow = [];
    for (DateTime item in lista) {
      listWeekShow.add(Dia(item.day, item.month, item.year, item.weekday));
    }

    return listWeekShow;
  }

  String semanaExibida() {
    if (listWeekShow != null && listWeekShow.isNotEmpty) {
      return '${listWeekShow.first.dia}/${listWeekShow.first.mes}/${listWeekShow.first.ano} - ${listWeekShow.last.dia}/${listWeekShow.last.mes}/${listWeekShow.last.ano}';
    }
    return '-';
  }

  @action
  proximaSemana() {
    dayWeek = dayWeek.add(Duration(days: 7));
    showWeekCalendar(dayWeek);
  }

  @action
  anteriorSemana() {
    dayWeek = dayWeek.add(Duration(days: -7));
    showWeekCalendar(dayWeek);
  }

  String diaShowLong() {
    if (diaShow != null) {
      return '${diaShow.dia}/${diaShow.mes}/${diaShow.ano}';
    }
    return '-';
  }

  @action
  anteriorDia() {
    dia = dia.add(Duration(days: -1));
    diaShow = Dia(dia.day, dia.month, dia.year, dia.weekday);
  }

  @action
  proximoDia() {
    dia = dia.add(Duration(days: 1));
    diaShow = Dia(dia.day, dia.month, dia.year, dia.weekday);
  }

//
//
//
//events
//

  List<Evento> findEventsDay(Dia dia) {
    List<Evento> listaEventosDia = [];
    listaEventos.forEach((key, value) {
      if (dia.dia == value.dataInicial.day &&
          dia.mes == value.dataInicial.month &&
          dia.ano == value.dataInicial.year) {
        listaEventosDia.add(value);
      }
    });
    listaEventosDia
        .sort((a, b) => a.dataInicial.hour.compareTo(b.dataInicial.hour));
    return listaEventosDia;
  }
}

import 'package:calendario/constantes/DateUtils.dart';
import 'package:calendario/model/dia.dart';
import 'package:calendario/model/evento.dart';
import 'package:calendario/screen/controller/calendario_controller.dart';
import 'package:calendario/screen/screen/calendario_day_screen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

ScrollController scrollController;
ScrollController scrollController2;
DateUtils _dataUtil;

Widget calendarWeek(context, BoxConstraints constraints) {
  final calendController = Provider.of<CalendarioController>(context);
  calendController.semanaExibida();
  scrollController2 = ScrollController();
  scrollController = ScrollController()
    ..addListener(() {
      scrollController2.jumpTo(scrollController.offset);
      //print("offset = ${scrollController.offset}");
    });

  return Expanded(
    child: Column(
      children: [
        rowTitleWeek(context, constraints, calendController.listWeekShow),
        Expanded(
          child: Stack(
            children: [
              _buildBack(), //lista linhas
              _buildEvents(context, calendController),
            ],
          ),
        ),
      ],
    ),
  );
}

_buildBack() {
  List<Widget> widsTime = [];

  for (var i = 0; i <= 24; i++) {
    widsTime.add(
      Container(
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              i > 23 ? '' : '$i:00',
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
  return ListView(
    controller: scrollController2,
    children: widsTime,
  );
}

_buildEvents(context, CalendarioController calendController) {
  List<Widget> listEvents = [];
  listEvents.add(
    Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            right: BorderSide(width: 2, color: Colors.green),
          ),
        ),
        height: 1460,
      ),
    ),
  );
  for (Dia item in calendController.listWeekShow) {
    listEvents.add(
      Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.blue,
            border: Border(
              right: BorderSide(width: 2, color: Colors.green),
            ),
          ),
          height: 1460,
          child: Stack(
            children: _buildEventsWids(item),
          ),
        ),
      ),
    );
  }

  return ListView(
    controller: scrollController,
    children: [
      Row(
        children: listEvents,
      )
    ],
  );
}

_buildEventsWids(Dia dia) {
  List<Evento> le = calendController.findEventsDay(dia);
  List<Widget> wids = [];

  if (le != null && le.isNotEmpty) {
    for (var di in le) {
      double margem = (di.dataInicial.hour.toDouble() * 60) +
          (di.dataInicial.minute.toDouble() + 8);
      wids.add(
        GestureDetector(
          onTap: () {
            print(di.titulo);
          },
          child: Container(
            margin: EdgeInsets.only(top: margem),
            width: double.infinity,
            height: di.duracao,
            child: Card(
              color: Colors.red,
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(di.titulo),
            ),
          ),
        ),
      );
    }
    return wids;
  } else {
    wids.add(
      Container(),
    );
    return wids;
  }
}

Widget rowTitleWeek(context, constraints, List<Dia> dias) {
  _dataUtil = DateUtils();

  List<Widget> widsDay = [];
  widsDay.add(
    Expanded(
      flex: 1,
      child: Container(),
    ),
  );
  for (var dia in dias) {
    widsDay.add(
      Expanded(
        flex: 3,
        child: Column(
          children: [
            Text(
              _dataUtil.daysOfWeekPos[dia.diaSemana],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isNowDay(dia) ? Colors.blue : Colors.green,
                fontWeight: isNowDay(dia) ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(
              '${dia.dia}/${dia.mes}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isNowDay(dia) ? Colors.blue : Colors.green,
                fontWeight: isNowDay(dia) ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Row(
    children: widsDay,
  );
}

isNowDay(Dia dia) {
  return dia.dia == _dataUtil.dayNow.day &&
      dia.mes == _dataUtil.dayNow.month &&
      dia.ano == _dataUtil.dayNow.year;
}

import 'package:calendario/model/evento.dart';
import 'package:calendario/screen/controller/calendario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ScrollController scrollController;
ScrollController scrollController2;
final calendController = CalendarioController();

Widget calendarDay(context, BoxConstraints constraints) {
  final calendController = Provider.of<CalendarioController>(context);
  scrollController2 = ScrollController();
  scrollController = ScrollController()
    ..addListener(() {
      scrollController2.jumpTo(scrollController.offset);
    });

  return Expanded(
    child: Stack(
      children: [
        _buildBack(), //lista linhas
        _buildEvents(context, constraints, calendController),
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              i > 23 ? '' : '$i:00',
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                indent: 30,
                height: 5,
                color: Colors.green,
              ),
            ),
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

_buildEvents(context, BoxConstraints constraints,
    CalendarioController calendController) {
  List<Evento> listaEventosDia =
      calendController.findEventsDay(calendController.diaShow);
  List<Widget> listEventsWids = [];
  double paddingObj = 0;
  listEventsWids.add(
    Container(
      margin: const EdgeInsets.only(top: 1463),
      child: Divider(
        color: Colors.black,
        thickness: 2,
      ),
    ),
  );
  for (Evento ev in listaEventosDia) {
    paddingObj = ((ev.dataInicial.hour * 60) + 30).toDouble();
    listEventsWids.add(
      GestureDetector(
        onTap: () {
          print(ev.titulo);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: paddingObj, left: constraints.maxWidth * 0.048, right: 3),
          child: cardEvent(ev),
        ),
      ),
    );
  }

  return ListView(
    controller: scrollController,
    children: [
      Stack(
        children: listEventsWids,
      )
    ],
  );
}

Widget cardEvent(Evento evento) {
  return Card(
    margin: const EdgeInsets.all(0),
    color: Colors.red,
    child: Container(
      height: evento.duracao,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                evento.titulo,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (evento.duracao > 80)
              Expanded(
                child: Text(
                  evento.subTitulo,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (evento.duracao > 80)
              Expanded(
                child: Text(
                  'Hora de início: ${evento.dataInicial.hour}:${evento.dataInicial.minute} ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (evento.duracao > 80)
              Text(
                'Duração: ${evento.duracao} Minutos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    ),
  );
}

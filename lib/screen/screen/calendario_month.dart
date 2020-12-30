import 'package:calendario/model/dia.dart';
import 'package:calendario/model/evento.dart';
import 'package:calendario/screen/controller/calendario_controller.dart';
import 'package:calendario/screen/state_app/app_state.dart';
import 'package:calendario/screen/widgets/row_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget calendario(
  context,
  constraints,
) {
  final calendController = Provider.of<CalendarioController>(context);
  var escala = 1.0;
  if ((constraints.maxWidth) > constraints.maxHeight) {
    escala = (constraints.maxWidth / constraints.maxHeight);
  } else {
    escala = (constraints.maxWidth / (constraints.maxHeight + 0.5));
  }

  var list = calendController.seqDiasSemanaTotal;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
        child: rowTitle(context, constraints),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 3),
        ),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: escala,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            Dia entity = list[index];
            return GestureDetector(
              onTap: () {
                if (list[index].dia != 0) {
                  calendController.changeState(AppLoadingState());
                  calendController.daySelected = entity;
                  print(entity.dia);
                  calendController.changeState(AppIdleState());
                }
              },
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: calendController.daySelected == entity
                      ? null
                      : Border.all(color: Colors.green, width: .1),
                  color: calendController.daySelected == entity
                      ? Colors.green
                      : Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      list[index].dia == 0 ? '' : '${list[index].dia}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: calendController.daySelected == entity
                            ? _verificaDataAtual(entity, calendController)
                                ? Colors.black
                                : Colors.white
                            : _verificaDataAtual(entity, calendController)
                                ? Colors.red
                                : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: calendController.daySelected == entity
                            ? _verificaDataAtual(entity, calendController)
                                ? 18
                                : 15
                            : _verificaDataAtual(entity, calendController)
                                ? 18
                                : 15,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _buildEvents(entity, calendController),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

_buildEvents(Dia dia, CalendarioController calendController) {
  List<Widget> wids = [];
  List<Evento> listEvento = [];

  listEvento = calendController.findEventsDay(dia);
  if (listEvento != null && listEvento.isNotEmpty) {
    for (Evento event in listEvento) {
      wids.add(
        Container(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              print(event.titulo);
            },
            child: Card(
              elevation: 1,
              color: Colors.red,
              margin: const EdgeInsets.all(1),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Text(
                  event.titulo,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  return wids;
}

bool _verificaDataAtual(Dia entity, calendController) {
  if (calendController.dateUtil.dayNow.day == entity.dia &&
      calendController.dateUtil.dayNow.month == entity.mes &&
      calendController.dateUtil.dayNow.year == entity.ano) return true;
  return false;
}

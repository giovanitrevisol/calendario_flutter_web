import 'package:calendario/constantes/DateUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget rowTitle(context, constraints) {
  List<Widget> wids = [];
  var listaSemana = DateUtils().daysOfWeek;
  if (constraints.maxWidth > 760) {
    listaSemana = DateUtils().daysOfWeek;
  } else {
    listaSemana = DateUtils().daysOfWeekShort;
  }
  for (var dia in listaSemana) {
    wids.add(
      Expanded(
        child: Container(
          child: Text(
            dia,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  return Row(
    children: wids,
  );
}

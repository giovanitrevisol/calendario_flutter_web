import 'evento.dart';

class Dia {
  int dia;
  int mes;
  int ano;
  int diaSemana;
  List<Evento> eventos;

  Dia(
    this.dia,
    this.mes,
    this.ano,
    this.diaSemana,
  );

  Dia.empity();
}

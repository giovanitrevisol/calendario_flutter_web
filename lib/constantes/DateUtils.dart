import 'dart:core';

class DateUtils {
  DateTime dayNow = DateTime.now();
  get todayCurrent => dayNow.day;
  get monthCorrent => dayNow.month;
  get yearCorrent => dayNow.year;

  ///returna STRING data atual
  String get todayDate => '$todayCurrent/$monthCorrent/$yearCorrent';

  ///retorna da por extenso
  String get todayDateLong =>
      '$todayCurrent de ${this.month(monthCorrent)} de $yearCorrent';

  ///retorna o dia da semana - D S T Q Q S S
  String get todayWeek {
    if (dayNow.weekday == 7) {
      return daysOfWeekPos[0];
    } else {
      return daysOfWeekPos[dayNow.weekday];
    }
  }

  ///retorna dias da semana por extenso
  List<String> daysOfWeekPos = [
    '',
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
    'Domingo',
  ];

  //usado apenas para listar
  List<String> daysOfWeek = [
    'Domingo',
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
  ];

  ///dia da semana - letra
  List<String> daysOfWeekShortPos = [
    '',
    'S',
    'T',
    'Q',
    'Q',
    'S',
    'S',
    'D',
  ];
  //usado apenas para listar
  List<String> daysOfWeekShort = [
    'D',
    'S',
    'T',
    'Q',
    'Q',
    'S',
    'S',
  ];

  /// 1 - janeiro até 12 dezembro
  month(int monthNum) {
    List<String> month = [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro",
    ];
    return month[monthNum - 1];
  }

  ///Quantidade de dias em cada mês
  daysInMonth(int monthNum, int year) {
    List<int> monthLength = new List(12);

    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true)
      monthLength[1] = 29;
    else
      monthLength[1] = 28;

    return monthLength[monthNum - 1];
  }

//ano bissexto
  leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;
    return leapYear;
  }

  ///ano de 366 dias
  leapYear366(int year) {
    int anoBissexto = 0;

    for (int counter = 1; counter < year; counter++) {
      if (counter >= 4) {
        if (leapYear(counter) == true)
          anoBissexto += 366;
        else
          anoBissexto += 365;
      } else
        anoBissexto += 365;
    }
    return anoBissexto;
  }

  daysPastInYear(int monthNum, int dayNum, int year) {
    int totalMonthLength = 0;

    for (int count = 1; count < monthNum; count++) {
      totalMonthLength += daysInMonth(count, year);
    }

    int monthLengthTotal = totalMonthLength + dayNum;

    return monthLengthTotal;
  }

  totalLengthOfDays(int monthNum, int dayNum, int year) {
    return (daysPastInYear(monthNum, dayNum, year) + leapYear366(year));
  }

  getWeek(int monthNum, int dayNum, int year) {
    int a = (daysPastInYear(monthNum, dayNum, year) / 7) + 1;
    return a.toInt();
  }
}

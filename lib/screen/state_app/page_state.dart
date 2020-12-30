enum PageStateEnum {
  MONTH,
  WEEK,
  DAY,
}

extension on PageStateEnum {
  static Map<PageStateEnum, String> names = {
    PageStateEnum.MONTH: 'Mês',
    PageStateEnum.WEEK: 'Semana',
    PageStateEnum.DAY: 'Dia',
  };
  String get name => names[this];
}

class PageState {
  final PageStateEnum type;

  PageState({this.type});

  @override
  String toString() {
    return this.type.name;
  }
}

class PageMonthState extends PageState {
  PageMonthState() : super(type: PageStateEnum.MONTH);
}

class PageWeekState extends PageState {
  PageWeekState() : super(type: PageStateEnum.WEEK);
}

class PageDayState extends PageState {
  PageDayState() : super(type: PageStateEnum.DAY);
}

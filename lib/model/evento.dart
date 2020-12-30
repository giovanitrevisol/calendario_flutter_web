import 'dart:convert';

class Evento {
  final String titulo;
  final String subTitulo;
  final String descricao;
  final DateTime dataInicial;
  final DateTime dataFinal;
  final double duracao;

  Evento(
    this.titulo,
    this.subTitulo,
    this.descricao,
    this.dataInicial,
    this.dataFinal,
    this.duracao,
  );

  duracaoConsulta() {
    int tempoConsulta = this.dataFinal.difference(this.dataInicial).inMinutes;
    return tempoConsulta;
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'subTitulo': subTitulo,
      'descricao': descricao,
      'dataInicial': dataInicial?.millisecondsSinceEpoch,
      'dataFinal': dataFinal?.millisecondsSinceEpoch,
      'duracao': duracao,
    };
  }

  factory Evento.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Evento(
      map['titulo'],
      map['subTitulo'],
      map['descricao'],
      DateTime.fromMillisecondsSinceEpoch(map['dataInicial']),
      DateTime.fromMillisecondsSinceEpoch(map['dataFinal']),
      map['duracao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Evento.fromJson(String source) => Evento.fromMap(json.decode(source));
}

class Ticket {
  String id;
  final String codTicket;
  final String descTicket;
  final int horasEstimadas;
  final int horasConsumidas;
  final String finalizadaSN;
  final String empresaAsignada;

  Ticket(
      {this.id = '',
      required this.codTicket,
      required this.descTicket,
      required this.horasEstimadas,
      required this.horasConsumidas,
      required this.finalizadaSN,
      required this.empresaAsignada});

  Map<String, dynamic> toJson() => {
        'id': id,
        'codTicket': codTicket,
        'descTicket': descTicket,
        'horasEstimadas': horasEstimadas,
        'horasConsumidas': horasConsumidas,
        'finalizadaSN': finalizadaSN,
        'empresaAsignada': empresaAsignada,
      };

  static Ticket fromJson(Map<String, dynamic> json) => Ticket(
        id: json['id'],
        codTicket: json['codTicket'],
        descTicket: json['descTicket'],
        horasEstimadas: json['horasEstimadas'],
        horasConsumidas: json['horasConsumidas'],
        finalizadaSN: json['finalizadaSN'],
        empresaAsignada: json['empresaAsignada'],
      );
}

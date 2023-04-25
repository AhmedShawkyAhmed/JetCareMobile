class PeriodModel {
  int? id, relationId, available;
  String? from;
  String? to;

  PeriodModel({
    this.id,
    this.from,
    this.to,
    this.available,
    this.relationId,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) => PeriodModel(
        id: json['id'] ?? 0,
        from: json['from'] ?? "",
        to: json['to'] ?? "",
        relationId: json['relationId'] ?? 0,
        available: json['available'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'to': to,
        'relationId': relationId,
        'available': available,
      };
}

class CalendarModel {
  int? id, areaId, requests;
  num? price;
  String? day, month, year, date;

  CalendarModel({
    this.id,
    this.price,
    this.day,
    this.month,
    this.year,
    this.requests,
    this.date,
    this.areaId,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        id: json['id'] ?? 0,
        areaId: json['areaId'] ?? 0,
        requests: json['requests'] ?? 0,
        price: json['price'] ?? 0,
        date: json['date'] ?? "",
        day: json['day'] ?? "",
        month: json['month'] ?? "",
        year: json['year'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'areaId': areaId,
        'requests': requests,
        'price': price,
        'date': date,
        'day': day,
        'month': month,
        'year': year,
      };
}

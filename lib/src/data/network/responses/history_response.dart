import 'package:jetcare/src/data/models/corporate_model.dart';
import 'package:jetcare/src/features/crew/data/models/order_model.dart';

class HistoryResponse {
  int? status;
  String? message;
  List<OrderModel>? orders;
  List<OrderModel>? ordersHistory;
  List<CorporateModel>? corporates;

  HistoryResponse({
    this.status,
    this.message,
    this.orders,
    this.corporates,
    this.ordersHistory,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        corporates: json["corporate"] != null
            ? List<CorporateModel>.from(
                json["corporate"].map((x) => CorporateModel.fromJson(x)))
            : json["corporate"],
        orders: json["orders"] != null
            ? List<OrderModel>.from(
                json["orders"].map((x) => OrderModel.fromJson(x)))
            : json["orders"],
        ordersHistory: json["history"] != null
            ? List<OrderModel>.from(
                json["history"].map((x) => OrderModel.fromJson(x)))
            : json["history"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "history": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "corporate": List<dynamic>.from(corporates!.map((x) => x.toJson())),
      };
}

import 'package:jetcare/src/data/models/cart_model.dart';

class CartResponse {
  int? status;
  String? message;
  List<CartModel>? cart;
  num? total;

  CartResponse({
    this.status,
    this.message,
    this.cart,
    this.total,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        status: json['status'] ?? 0,
        message: json['message'] ?? "",
        cart: json["cart"] != null
            ? List<CartModel>.from(
                json["cart"].map((x) => CartModel.fromJson(x)))
            : json["cart"],
        total: json['total'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total": total,
        "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

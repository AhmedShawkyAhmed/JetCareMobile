class OrderRequest {
  num periodId, addressId,relationId;
  String date, total,price,shipping;
  String? comment;
  List<int> cart;

  OrderRequest({
    required this.total,
    required this.relationId,
    required this.price,
    required this.shipping,
    required this.addressId,
    required this.periodId,
    required this.date,
    required this.cart,
    this.comment,
  });
}

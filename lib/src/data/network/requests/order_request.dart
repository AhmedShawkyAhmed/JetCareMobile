class OrderRequest {
  num periodId, addressId, total;
  String date;
  String? comment;
  List<int> cart;

  OrderRequest({
    required this.total,
    required this.addressId,
    required this.periodId,
    required this.date,
    required this.cart,
    this.comment,
  });
}

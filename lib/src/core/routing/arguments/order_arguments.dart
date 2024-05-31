import 'package:jetcare/src/features/shared/models/order_model.dart';

class OrderArguments{
  OrderModel order;
  String? type;

  OrderArguments({
    required this.order,
    this.type,
});
}
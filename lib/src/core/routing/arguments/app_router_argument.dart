
import 'package:jetcare/src/data/models/corporate_model.dart';
import 'package:jetcare/src/features/crew/data/models/order_model.dart';
import 'package:jetcare/src/features/home/data/models/item_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';

class AppRouterArgument {
  final String? type;
  final String? total;
  final ItemModel? itemModel;
  final PackageModel? packageModel;
  final OrderModel? orderModel;
  final CorporateModel? corporateModel;

  AppRouterArgument({
    this.type,
    this.total,
    this.itemModel,
    this.packageModel,
    this.orderModel,
    this.corporateModel,
  });
}

import 'package:jetcare/src/data/models/address_model.dart';
import 'package:jetcare/src/data/models/corporate_model.dart';
import 'package:jetcare/src/data/models/info_model.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/order_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';

class AppRouterArgument {
  final String? type;
  final String? total;
  final ItemModel? itemModel;
  final PackageModel? packageModel;
  final OrderModel? orderModel;
  final CorporateModel? corporateModel;
  final InfoModel? infoModel;
  final AddressModel? addressModel;

  AppRouterArgument({
    this.type,
    this.total,
    this.itemModel,
    this.packageModel,
    this.orderModel,
    this.corporateModel,
    this.infoModel,
    this.addressModel,
  });
}

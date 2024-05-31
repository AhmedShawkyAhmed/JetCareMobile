import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/arguments/order_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:jetcare/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrdersCubit cubit = BlocProvider.of(context);

  @override
  void initState() {
    cubit.getMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is GetMyOrdersLoading) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return LoadingView(
                height: 10.h,
              );
            },
          );
        }
        return cubit.orders.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 2.h),
                itemCount: cubit.orders.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      NavigationService.pushNamed(
                        Routes.confirmOrder,
                        arguments: OrderArguments(
                          order: cubit.orders[index],
                        ),
                      );
                    },
                    child: CartItem(
                      withDelete: false,
                      onDelete: () {},
                      name: "# ${cubit.orders[index].id.toString()}",
                      count: cubit.orders[index].date.toString(),
                      price: cubit.orders[index].total.toString(),
                      image: "1674441185.jpg",
                    ),
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: DefaultText(
                  text: translate(AppStrings.noOrders),
                ),
              );
      },
    );
  }
}

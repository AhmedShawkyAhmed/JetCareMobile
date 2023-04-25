import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/data/network/requests/order_request.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/summery_item.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrderScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  ConfirmOrderScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultText(
                    text: translate(AppStrings.summery),
                    fontSize: 22.sp,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 2.h,
                  bottom: 5.h,
                ),
                width: 80.w,
                height: 1.5.sp,
                color: AppColors.pc,
              ),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 65,
                  ),
                  padding: EdgeInsets.zero,
                  itemCount: orderSummery.length,
                  itemBuilder: (context, index) {
                    return SummeryItem(
                      visible: !orderSummery[index].value.contains("null"),
                      title: translate(orderSummery[index].key),
                      sub: orderSummery[index].key == AppStrings.total
                          ? "${orderSummery[index].value} ${translate(AppStrings.currency)}"
                          : orderSummery[index].value,
                    );
                  },
                ),
              ),
              DefaultTextField(
                controller: commentController,
                hintText: translate(AppStrings.addComment),
                maxLine: 10,
                height: 25.h,
                maxLength: 500,
              ),
              DefaultAppButton(
                title: translate(AppStrings.confirm),
                onTap: () {
                  IndicatorView.showIndicator(context);
                  OrderCubit.get(context).createOrder(
                    orderRequest: OrderRequest(
                      userId: globalAccountModel.id!,
                      total: int.parse(orderSummery.last.value.toString()),
                      addressId: selectedAddress.id!,
                      date: dateController.text,
                      spaceId: selectedSpace.id,
                      packageId: appRouterArgument.packageModel?.id,
                      itemId: appRouterArgument.itemModel?.id,
                      periodId: selectedPeriod.id!,
                      extraIds: extrasIds,
                      comment: commentController.text == ""
                          ? null
                          : commentController.text,
                    ),
                    afterSuccess: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouterNames.success,
                        arguments: AppRouterArgument(
                          type: "order",
                        ),
                        (route) => false,
                      );
                      disposeConstants();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

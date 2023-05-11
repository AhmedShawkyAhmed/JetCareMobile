import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatelessWidget {
  final AppRouterArgument appRouterArgument;

  const SuccessScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 20.h,
              child: Image.asset("assets/images/success.png"),
            ),
            SizedBox(
              height: 5.h,
            ),
            DefaultText(
              text: translate(AppStrings.orderSuccess),
              align: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 70.w,
              child: DefaultText(
                text: appRouterArgument.type == "order"
                    ? translate(AppStrings.orderMessage)
                    : translate(AppStrings.supportMessage),
                maxLines: 2,
                align: TextAlign.center,
              ),
            ),
            const Spacer(),
            DefaultAppButton(
              title: translate(AppStrings.con),
              onTap: () {
                if (appRouterArgument.type == "order") {
                  AppCubit.get(context).changeIndex(0);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouterNames.layout,
                    (route) => false,
                  );
                  OrderCubit.get(context).getMyOrders();
                } else if (appRouterArgument.type == "support") {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

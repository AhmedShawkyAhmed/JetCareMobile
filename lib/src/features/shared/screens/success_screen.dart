import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessType type;

  const SuccessScreen({
    required this.type,
    super.key,
  });

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
                text: type == SuccessType.order
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
                if (type == SuccessType.order) {
                  LayoutCubit().changeIndex(0);
                  NavigationService.pushNamedAndRemoveUntil(
                    Routes.layout,
                    (route) => false,
                  );
                  OrderCubit(instance()).getMyOrders();
                } else if (type == SuccessType.support) {
                  NavigationService.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

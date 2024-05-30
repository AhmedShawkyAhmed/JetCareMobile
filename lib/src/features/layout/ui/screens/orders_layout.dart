import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/features/corporate/ui/screens/corporate_orders_screen.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/presentation/screens/user/history_screen.dart';
import 'package:sizer/sizer.dart';

class OrdersLayout extends StatefulWidget {
  const OrdersLayout({super.key});

  @override
  State<OrdersLayout> createState() => _OrdersLayoutState();
}

class _OrdersLayoutState extends State<OrdersLayout> {
  bool myOrder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultText(
                  text: translate(AppStrings.myOrders),
                  onTap: () {
                    setState(() {
                      myOrder = true;
                    });
                  },
                  textColor: myOrder ? AppColors.white : AppColors.silver,
                ),
                DefaultText(
                  text: translate(AppStrings.corporate),
                  onTap: () {
                    setState(() {
                      myOrder = false;
                    });
                  },
                  textColor: myOrder ? AppColors.silver : AppColors.white,
                ),
              ],
            ),
            Expanded(
              child: myOrder ? const HistoryScreen() : const CorporateOrdersScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

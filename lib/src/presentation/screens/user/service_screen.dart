import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class ServiceScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const ServiceScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool edit = false;
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: true,
        widget: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                    child: CardView(
                      title: CacheHelper.getDataFromSharedPreference(
                          key: SharedPreferenceKeys.language) ==
                          "ar"
                          ? widget.appRouterArgument.itemModel!.nameAr
                          : widget.appRouterArgument.itemModel!.nameEn,
                      image: widget.appRouterArgument.itemModel!.image,
                      height: 19.h,
                      mainHeight: 25.h,
                      titleFont: 17.sp,
                      colorMain: AppColors.pc.withOpacity(0.8),
                      colorSub: AppColors.shade.withOpacity(0.4),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: DefaultText(
                      text: translate(AppStrings.description),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: DefaultText(
                        maxLines: 17,
                        text: CacheHelper.getDataFromSharedPreference(
                            key: SharedPreferenceKeys.language) ==
                            "ar"
                            ? widget.appRouterArgument.itemModel!.descriptionAr!
                            : widget.appRouterArgument.itemModel!.descriptionEn!,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  edit
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextField(
                        width: 70.w,
                        marginVertical: 0,
                        marginHorizontal: 5.w,
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                        hintText: translate(AppStrings.count),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          text: translate(AppStrings.save),
                          onTap: () {
                            setState(() {
                              quantity = int.parse(quantityController.text == ""
                                  ? "1"
                                  : quantityController.text);
                              widget.appRouterArgument.itemModel!.quantity =
                                  quantity;
                              edit = !edit;
                            });
                          },
                          textColor: AppColors.pc,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          fontSize: 13.sp,
                          text: translate(AppStrings.count),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          fontSize: 13.sp,
                          text:
                          "$quantity ${widget.appRouterArgument.itemModel!.unit}",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          text: translate(AppStrings.update),
                          onTap: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          textColor: AppColors.pc,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: DefaultText(
                          text:
                          "${translate(AppStrings.price)} : ${widget.appRouterArgument.itemModel!.price!.toInt() * quantity} ${translate(AppStrings.currency)}",
                        ),
                      ),
                    ],
                  ),
                  DefaultAppButton(
                    title: translate(AppStrings.appointment),
                    onTap: () {
                      if (edit) {
                        DefaultToast.showMyToast(translate(AppStrings.saveFirst));
                      } else {
                        setState(() {
                          widget.appRouterArgument.itemModel!.price = widget
                              .appRouterArgument.itemModel!.price!
                              .toInt() *
                              quantity;
                        });
                        Navigator.pushNamed(
                          context,
                          AppRouterNames.appointment,
                          arguments: AppRouterArgument(
                            type: "item",
                            itemModel: widget.appRouterArgument.itemModel,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

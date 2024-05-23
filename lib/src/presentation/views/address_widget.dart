import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/data/models/address_model.dart';
import 'package:sizer/sizer.dart';


class AddressWidget extends StatefulWidget {
  final AddressModel addressModel;
  final List<AddressModel> addressModelList;
  final VoidCallback edit, delete;
  final Color? color;

  const AddressWidget({
    required this.addressModel,
    required this.addressModelList,
    required this.delete,
    required this.edit,
    this.color,
    super.key,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: widget.addressModelList.isNotEmpty
          ? EdgeInsets.only(right: 2.h, top: 2.h)
          : EdgeInsets.only(top: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color ?? AppColors.shade.withOpacity(0.1),
      ),
      child: widget.addressModelList.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        text: "${widget.addressModel.address}",
                        fontSize: 10.sp,
                        maxLines: 1,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      DefaultText(
                        text:
                            "${translate(AppStrings.addressArea)}: ${widget.addressModel.area!.nameAr} - ${widget.addressModel.state!.nameAr}",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      DefaultText(
                        text:
                            "${translate(AppStrings.orderPhone)} ${widget.addressModel.phone}",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      text: "${widget.addressModel.address}",
                      fontSize: 10.sp,
                      maxLines: 1,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    DefaultText(
                      text:
                          "${translate(AppStrings.addressArea)}: ${widget.addressModel.area!.nameAr} - ${widget.addressModel.state!.nameAr}",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    DefaultText(
                      text:
                          "${translate(AppStrings.orderPhone)} ${widget.addressModel.phone}",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      children: [
                        DefaultAppButton(
                          width: 15.w,
                          height: 3.h,
                          radius: 5,
                          marginHorizontal: 0,
                          title: translate(AppStrings.update),
                          fontSize: 10.sp,
                          onTap: widget.edit,
                        ),
                        DefaultAppButton(
                          width: 15.w,
                          height: 3.h,
                          radius: 5,
                          marginHorizontal: 5.w,
                          title: translate(AppStrings.delete),
                          buttonColor: AppColors.darkRed,
                          fontSize: 10.sp,
                          onTap: widget.delete,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

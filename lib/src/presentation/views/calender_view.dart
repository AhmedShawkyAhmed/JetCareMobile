import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/shared/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/presentation/views/calender_item_view.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/app_colors.dart';

class CalenderView extends StatefulWidget {
  final AreaModel areaModel;

  const CalenderView({
    required this.areaModel,
    super.key,
  });

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        CalenderCubit(instance()).getCalender(
                          month: CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .month ==
                                  12
                              ? 1
                              : (CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .month! +
                                  1),
                          year:
                              CalenderCubit(instance())
                                          .calenderList
                                          .first
                                          .month ==
                                      12
                                  ? (CalenderCubit(instance())
                                          .calenderList
                                          .first
                                          .year! +
                                      1)
                                  : CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .year!,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DefaultText(
                        text: CalenderCubit(instance()).calenderList.isEmpty
                            ? ""
                            : "${CalenderCubit(instance()).calenderList.first.monthName} - ${CalenderCubit(instance()).calenderList.first.year!}"),
                    InkWell(
                      onTap: () {
                        CalenderCubit(instance()).getCalender(
                          month: CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .month ==
                                  1
                              ? 12
                              : (CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .month! -
                                  1),
                          year: CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .month ==
                                  1
                              ? (CalenderCubit(instance())
                                      .calenderList
                                      .first
                                      .year! -
                                  1)
                              : CalenderCubit(instance())
                                  .calenderList
                                  .first
                                  .year!,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return CalenderCubit(instance()).calenderList.isEmpty
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              if (widget.areaModel.id == -1) {
                                DefaultToast.showMyToast(
                                    translate(AppStrings.selectLocation));
                              } else {
                                setState(() {
                                  discountPeriods = CalenderCubit(instance())
                                      .calenderList[index]
                                      .periods!;
                                  selected = index;
                                });
                              }
                            },
                            child: CalenderItemView(
                              color: selected == index
                                  ? AppColors.primary
                                  : CalenderCubit(instance())
                                          .calenderList[index]
                                          .periods!
                                          .isEmpty
                                      ? null
                                      : CalenderCubit(instance())
                                                  .calenderList[index]
                                                  .areas!
                                                  .first
                                                  .id ==
                                              widget.areaModel.id
                                          ? AppColors.gold
                                          : null,
                              day: CalenderCubit(instance())
                                  .calenderList[index]
                                  .day
                                  .toString(),
                            ),
                          );
                  },
                  itemCount: CalenderCubit(instance()).calenderList.isEmpty
                      ? 0
                      : CalenderCubit(instance()).calenderList.length,
                ),
              ),
              DefaultText(
                text: translate(AppStrings.selectedDays),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.chooseTime),
                      fontSize: 15.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
                child: BlocBuilder<GlobalCubit, GlobalState>(
                  builder: (context, state) {
                    if (GlobalCubit(instance()).periodResponse?.periods ==
                        null) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: DefaultDropdown<PeriodModel>(
                        hint: translate(AppStrings.chooseTime),
                        showSearchBox: true,
                        itemAsString: (PeriodModel? u) =>
                            "${u?.from} - ${u?.to}",
                        items: discountPeriods.isEmpty
                            ? GlobalCubit(instance()).periodResponse!.periods!
                            : discountPeriods,
                        onChanged: (val) {
                          setState(() {
                            selectedPeriod = val!;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

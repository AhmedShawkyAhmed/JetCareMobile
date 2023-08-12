import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/data/models/area_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/presentation/views/calender_item_view.dart';
import 'package:jetcare/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../styles/app_colors.dart';

class CalenderView extends StatefulWidget {
  AreaModel areaModel;

  CalenderView({
    required this.areaModel,
    Key? key,
  }) : super(key: key);

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
                        CalenderCubit.get(context).getCalender(
                          month: CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .month ==
                                  12
                              ? 1
                              : (CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .month! +
                                  1),
                          year:
                              CalenderCubit.get(context)
                                          .calenderList
                                          .first
                                          .month ==
                                      12
                                  ? (CalenderCubit.get(context)
                                          .calenderList
                                          .first
                                          .year! +
                                      1)
                                  : CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .year!,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.pc),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.pc,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DefaultText(
                        text: CalenderCubit.get(context).calenderList.isEmpty
                            ? ""
                            : "${CalenderCubit.get(context).calenderList.first.monthName} - ${CalenderCubit.get(context).calenderList.first.year!}"),
                    InkWell(
                      onTap: () {
                        CalenderCubit.get(context).getCalender(
                          month: CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .month ==
                                  1
                              ? 12
                              : (CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .month! -
                                  1),
                          year: CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .month ==
                                  1
                              ? (CalenderCubit.get(context)
                                      .calenderList
                                      .first
                                      .year! -
                                  1)
                              : CalenderCubit.get(context)
                                  .calenderList
                                  .first
                                  .year!,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.pc),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.pc,
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
                    return CalenderCubit.get(context).calenderList.isEmpty
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              if (widget.areaModel.id == -1) {
                                DefaultToast.showMyToast(translate(AppStrings.selectLocation));
                              } else {
                                setState(() {
                                  discountPeriods = CalenderCubit.get(context)
                                      .calenderList[index]
                                      .periods!;
                                  selected = index;
                                });
                              }
                            },
                            child: CalenderItemView(
                              color: selected == index
                                  ? AppColors.pc
                                  : CalenderCubit.get(context)
                                          .calenderList[index]
                                          .periods!
                                          .isEmpty
                                      ? null
                                      : CalenderCubit.get(context)
                                                  .calenderList[index]
                                                  .areas!
                                                  .first
                                                  .id ==
                                              widget.areaModel.id
                                          ? AppColors.gold
                                          : null,
                              day: CalenderCubit.get(context)
                                  .calenderList[index]
                                  .day
                                  .toString(),
                            ),
                          );
                  },
                  itemCount: CalenderCubit.get(context).calenderList.isEmpty
                      ? 0
                      : CalenderCubit.get(context).calenderList.length,
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
                    if (GlobalCubit.get(context).periodResponse?.periods ==
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
                            ? GlobalCubit.get(context).periodResponse!.periods!
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

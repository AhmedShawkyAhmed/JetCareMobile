import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/NotificationDownloadingService.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/models/address_model.dart';
import 'package:jetcare/src/data/models/period_model.dart';
import 'package:jetcare/src/data/network/requests/order_request.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/address_widget.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/calender_item_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/area_model.dart';

class AppointmentScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const AppointmentScreen({
    required this.appRouterArgument,
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime now = DateTime.now();
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              primaryColorDark: Colors.teal,
              accentColor: Colors.teal,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd', 'en_US').format(picked);
      printSuccess(dateController.text);
    }
  }

  DateTime date = DateTime.now();
  int selected = -1;


  @override
  void initState() {
    discountAreas = AreaModel(id: -1);
    selectedAddress = AddressModel(id: -1);
    discountPeriods = [];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            SizedBox(
              height: 2.h,
            ),
            if (CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.password) !=
                null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultText(
                  text: translate(AppStrings.chooseAddress),
                  fontSize: 15.sp,
                ),
              ),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (AddressCubit.get(context).addressList.isEmpty ||
                      AddressCubit.get(context).addressResponse == null) {
                    return Center(
                      child: DefaultText(
                        text: translate(AppStrings.aAddress),
                        textColor: AppColors.pc,
                        onTap: () {
                          IndicatorView.showIndicator(context);
                          AddressCubit.get(context).getAllStates(
                              afterSuccess: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              AppRouterNames.addAddress,
                              arguments: AppRouterArgument(type: "new"),
                            );
                          });
                        },
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AddressCubit.get(context)
                        .addressResponse!
                        .address!
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedAddress = AddressCubit.get(context)
                                .addressResponse!
                                .address![index];
                          });
                        },
                        child: AddressWidget(
                          color: selectedAddress.id ==
                                  AddressCubit.get(context)
                                      .addressList[index]
                                      .id
                              ? AppColors.pc.withOpacity(0.5)
                              : AppColors.shade.withOpacity(0.1),
                          addressModelList:
                              AddressCubit.get(context).addressList,
                          addressModel:
                              AddressCubit.get(context).addressList[index],
                          edit: () {},
                          delete: () {},
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: DefaultText(
                text: translate(AppStrings.selectData),
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 56.h,
              child: BlocBuilder<CalenderCubit, CalenderState>(
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
                                  setState(() {
                                    selected = -1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(color: AppColors.pc),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Transform.rotate(
                                      angle: 180 * math.pi / 180,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.pc,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DefaultText(
                                  text: CalenderCubit.get(context)
                                          .calenderList
                                          .isEmpty
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
                                  setState(() {
                                    selected = -1;
                                  });
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 2.w,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return CalenderCubit.get(context)
                                      .calenderList
                                      .isEmpty
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: date.isBefore(DateTime.parse(
                                              CalenderCubit.get(context)
                                                  .calenderList[index]
                                                  .date
                                                  .toString()))
                                          ? () {
                                              if (selectedAddress.area == null || selectedAddress.area!.id == -1) {
                                                DefaultToast.showMyToast(
                                                    translate(AppStrings
                                                        .selectLocation));
                                              } else {
                                                setState(() {
                                                  if (CalenderCubit.get(context)
                                                      .calenderList[index]
                                                      .areas!
                                                      .isEmpty) {
                                                    discountAreas =
                                                        AreaModel(id: -1);
                                                  } else {
                                                    discountAreas =
                                                        CalenderCubit.get(
                                                                context)
                                                            .calenderList[index]
                                                            .areas!
                                                            .first;
                                                  }
                                                  dateController.text =
                                                      CalenderCubit.get(context)
                                                          .calenderList[index]
                                                          .date!;
                                                  discountPeriods =
                                                      CalenderCubit.get(context)
                                                          .calenderList[index]
                                                          .periods!;
                                                  selected = index;
                                                });
                                              }
                                            }
                                          : (){
                                        DefaultToast.showMyToast(translate(AppStrings.beforeDate));
                                      },
                                      child: CalenderItemView(
                                        color: date.isBefore(DateTime.parse(
                                                CalenderCubit.get(context)
                                                    .calenderList[index]
                                                    .date
                                                    .toString()))
                                            ? selected == index
                                                ? AppColors.pc
                                                : CalenderCubit.get(context)
                                                        .calenderList[index]
                                                        .periods!
                                                        .isEmpty
                                                    ? null
                                                    : CalenderCubit.get(context)
                                                                .calenderList[
                                                                    index]
                                                                .areas!
                                                                .first
                                                                .id ==
                                                            selectedAddress
                                                                .area?.id
                                                        ? shipping.isNotEmpty
                                                            ? AppColors.gold
                                                            : null
                                                        : null
                                            : AppColors.shade.withOpacity(0.4),
                                        day: CalenderCubit.get(context)
                                            .calenderList[index]
                                            .day
                                            .toString(),
                                      ),
                                    );
                            },
                            itemCount:
                                CalenderCubit.get(context).calenderList.isEmpty
                                    ? 0
                                    : CalenderCubit.get(context)
                                        .calenderList
                                        .length,
                          ),
                        ),
                        DefaultText(
                          text: translate(AppStrings.selectedDays),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
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
                              if (GlobalCubit.get(context)
                                      .periodResponse
                                      ?.periods ==
                                  null) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: DefaultDropdown<PeriodModel>(
                                  hint: "${translate(AppStrings.chooseTime)}             ",
                                  showSearchBox: true,
                                  itemAsString: (PeriodModel? u) =>
                                      "${u?.from} - ${u?.to}",
                                  items: shipping.isEmpty
                                      ? GlobalCubit.get(context)
                                          .periodResponse!
                                          .periods!
                                      : discountPeriods.isEmpty
                                          ? GlobalCubit.get(context)
                                              .periodResponse!
                                              .periods!
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
              ),
            ),
            DefaultTextField(
              controller: commentController,
              hintText: translate(AppStrings.addComment),
              maxLine: 10,
              marginHorizontal: 5.w,
              height: 15.h,
              maxLength: 500,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  DefaultText(
                    text: translate(AppStrings.price),
                  ),
                  const Spacer(),
                  DefaultText(
                    text:
                        " ${widget.appRouterArgument.total ?? 0} ${translate(AppStrings.currency)}",
                  ),
                ],
              ),
            ),
            if (shipping.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.shipping),
                    ),
                    const Spacer(),
                    DefaultText(
                      text: discountAreas.id == -1
                          ? " ${selectedAddress.area?.price?.toInt() ?? 0} ${translate(AppStrings.currency)}"
                          : discountAreas.id == selectedAddress.area!.id
                              ? " ${selectedAddress.area?.discount?.toInt() ?? 0} ${translate(AppStrings.currency)}"
                              : " ${selectedAddress.area?.price?.toInt() ?? 0} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
            ],
            Divider(
              endIndent: 10.w,
              indent: 10.w,
              color: AppColors.pc,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  DefaultText(
                    text: translate(AppStrings.total),
                  ),
                  const Spacer(),
                  DefaultText(
                    text:
                        " ${((double.parse(widget.appRouterArgument.total.toString())) + (shipping.isNotEmpty ? (discountAreas.id == -1 ? selectedAddress.area?.price?.toInt() ?? 0 : selectedAddress.area?.discount?.toInt() ?? 0) : 0))} ${translate(AppStrings.currency)}",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            DefaultAppButton(
              title: translate(AppStrings.confirm),
              onTap: () {
                if (dateController.text == "") {
                  DefaultToast.showMyToast(translate(AppStrings.selectData));
                } else if (selectedAddress.id == null ||
                    selectedAddress.id == 0) {
                  DefaultToast.showMyToast(translate(AppStrings.selectAddress));
                } else if (selectedPeriod.id == null ||
                    selectedPeriod.id == 0) {
                  DefaultToast.showMyToast(translate(AppStrings.selectTime));
                } else {
                  IndicatorView.showIndicator(context);
                  OrderCubit.get(context).createOrder(
                    orderRequest: OrderRequest(
                      total: ((double.parse(
                                  widget.appRouterArgument.total.toString())) +
                              (shipping.isNotEmpty
                                  ? (discountAreas.id == -1
                                      ? selectedAddress.area?.price?.toInt() ??
                                          0
                                      : selectedAddress.area?.discount
                                              ?.toInt() ??
                                          0)
                                  : 0))
                          .toString(),
                      price: widget.appRouterArgument.total.toString(),
                      relationId: selectedPeriod.relationId!,
                      shipping: shipping.isEmpty
                          ? "0"
                          : (discountAreas.id == -1
                                  ? selectedAddress.area?.price?.toInt() ?? 0
                                  : selectedAddress.area?.discount?.toInt() ??
                                      0)
                              .toString(),
                      periodId: selectedPeriod.id!,
                      addressId: selectedAddress.id!,
                      date: dateController.text,
                      comment: commentController.text == ""
                          ? null
                          : commentController.text,
                      cart: cart,
                    ),
                    afterSuccess: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRouterNames.success,
                        arguments: AppRouterArgument(
                          type: "order",
                        ),
                      );
                      NotificationCubit.get(context).saveNotification(
                        title: "الطلبات",
                        message: "تم إنشاء طلبك بنجاح و بإنتظار التأكيد",
                        afterSuccess: () {
                          NotificationService().showNotification(
                            id: 12,
                            title: "الطلبات",
                            body: "تم إنشاء طلبك بنجاح و بإنتظار التأكيد",
                          );
                        },
                      );
                      cart.clear();
                    },
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
    );
  }
}

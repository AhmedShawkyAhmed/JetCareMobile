import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/address/cubit/address_cubit.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/ui/widgets/address_widget.dart';
import 'package:jetcare/src/features/appointment/cubit/appointment_cubit.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';
import 'package:jetcare/src/features/appointment/data/models/space_model.dart';
import 'package:jetcare/src/features/appointment/ui/widgets/calender_item_view.dart';
import 'package:jetcare/src/features/shared/ui/views/body_view.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/ui/widgets/default_text_field.dart';
import 'package:jetcare/src/features/shared/ui/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class AppointmentScreen extends StatefulWidget {
  final AppRouterArgument appRouterArgument;

  const AppointmentScreen({
    required this.appRouterArgument,
    super.key,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentCubit appointmentCubit = BlocProvider.of(context);
  late AddressCubit addressCubit = BlocProvider.of(context);
  DateTime now = DateTime.now();
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  AddressModel selectedAddress = AddressModel(id: -1);
  AreaModel discountAreas = AreaModel(id: -1);
  PeriodModel selectedPeriod = PeriodModel();
  SpaceModel selectedSpace = SpaceModel();
  List<PeriodModel> discountPeriods = [];

  DateTime date = DateTime.now();
  int selected = -1;

  @override
  void initState() {
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
            if (CacheService.get(key: CacheKeys.token) != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DefaultText(
                  text: translate(AppStrings.chooseAddress),
                  fontSize: 15.sp,
                ),
              ),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (addressCubit.address.isEmpty) {
                    return Center(
                      child: DefaultText(
                        text: translate(AppStrings.aAddress),
                        textColor: AppColors.primary,
                        onTap: () {
                          NavigationService.pushNamed(
                            Routes.addAddress,
                          );
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
                    itemCount: addressCubit.address.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedAddress = addressCubit.address[index];
                          });
                        },
                        child: AddressWidget(
                          color: selectedAddress.id ==
                                  addressCubit.address[index].id
                              ? AppColors.primary.withOpacity(0.5)
                              : AppColors.shade.withOpacity(0.1),
                          addressModelList: addressCubit.address,
                          addressModel: addressCubit.address[index],
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
              child: BlocBuilder<AppointmentCubit, AppointmentState>(
                builder: (context, state) {
                  if (state is GetCalendarLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
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
                                  appointmentCubit.getCalendar(
                                    month:
                                        appointmentCubit.calendar.first.month ==
                                                12
                                            ? 1
                                            : (appointmentCubit
                                                    .calendar.first.month! +
                                                1),
                                    year:
                                        appointmentCubit
                                                    .calendar.first.month ==
                                                12
                                            ? (appointmentCubit
                                                    .calendar.first.year! +
                                                1)
                                            : appointmentCubit
                                                .calendar.first.year!,
                                  );
                                  setState(() {
                                    selected = -1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Transform.rotate(
                                      angle: 180 * math.pi / 180,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DefaultText(
                                  text: appointmentCubit.calendar.isEmpty
                                      ? ""
                                      : "${appointmentCubit.calendar.first.monthName} - ${appointmentCubit.calendar.first.year!}"),
                              InkWell(
                                onTap: () {
                                  appointmentCubit.getCalendar(
                                    month:
                                        appointmentCubit.calendar.first.month ==
                                                1
                                            ? 12
                                            : (appointmentCubit
                                                    .calendar.first.month! -
                                                1),
                                    year: appointmentCubit
                                                .calendar.first.month ==
                                            1
                                        ? (appointmentCubit
                                                .calendar.first.year! -
                                            1)
                                        : appointmentCubit.calendar.first.year!,
                                  );
                                  setState(() {
                                    selected = -1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Transform.rotate(
                                      angle: 1 * math.pi / 180,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.primary,
                                      ),
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
                              return appointmentCubit.calendar.isEmpty
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: date.isBefore(DateTime.parse(
                                              appointmentCubit
                                                  .calendar[index].date
                                                  .toString()))
                                          ? () {
                                              if (selectedAddress.area ==
                                                      null ||
                                                  selectedAddress.area!.id ==
                                                      -1) {
                                                DefaultToast.showMyToast(
                                                    translate(AppStrings
                                                        .selectLocation));
                                              } else {
                                                setState(() {
                                                  if (appointmentCubit
                                                      .calendar[index]
                                                      .areas!
                                                      .isEmpty) {
                                                    discountAreas =
                                                        AreaModel(id: -1);
                                                  } else {
                                                    discountAreas =
                                                        appointmentCubit
                                                            .calendar[index]
                                                            .areas!
                                                            .first;
                                                  }
                                                  dateController.text =
                                                      appointmentCubit
                                                          .calendar[index]
                                                          .date!;
                                                  discountPeriods =
                                                      appointmentCubit
                                                          .calendar[index]
                                                          .periods!;
                                                  selected = index;
                                                });
                                              }
                                            }
                                          : () {
                                              DefaultToast.showMyToast(
                                                  translate(
                                                      AppStrings.beforeDate));
                                            },
                                      child: CalenderItemView(
                                        color: date.isBefore(DateTime.parse(
                                                appointmentCubit
                                                    .calendar[index].date
                                                    .toString()))
                                            ? selected == index
                                                ? AppColors.primary
                                                : appointmentCubit
                                                        .calendar[index]
                                                        .periods!
                                                        .isEmpty
                                                    ? null
                                                    : appointmentCubit
                                                                .calendar[index]
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
                                        day: appointmentCubit
                                            .calendar[index].day
                                            .toString(),
                                      ),
                                    );
                            },
                            itemCount: appointmentCubit.calendar.isEmpty
                                ? 0
                                : appointmentCubit.calendar.length,
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
                          child: appointmentCubit.periods.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: DefaultDropdown<PeriodModel>(
                                    hint:
                                        "${translate(AppStrings.chooseTime)}             ",
                                    showSearchBox: true,
                                    itemAsString: (PeriodModel? u) =>
                                        "${u?.from} - ${u?.to}",
                                    items: shipping.isEmpty
                                        ? appointmentCubit.periods
                                        : discountPeriods.isEmpty
                                            ? appointmentCubit.periods
                                            : discountPeriods,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedPeriod = val!;
                                      });
                                    },
                                  ),
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
              color: AppColors.primary,
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
                // todo create order
                // if (dateController.text == "") {
                //   DefaultToast.showMyToast(translate(AppStrings.selectData));
                // } else if (selectedAddress.id == null ||
                //     selectedAddress.id == 0) {
                //   DefaultToast.showMyToast(translate(AppStrings.selectAddress));
                // } else if (selectedPeriod.id == null ||
                //     selectedPeriod.id == 0) {
                //   DefaultToast.showMyToast(translate(AppStrings.selectTime));
                // } else {
                //   IndicatorView.showIndicator();
                //   OrderCubit(instance()).createOrder(
                //     orderRequest: OrderRequest(
                //         total: ((double.parse(widget.appRouterArgument.total
                //                     .toString())) +
                //                 (shipping.isNotEmpty
                //                     ? (discountAreas.id == -1
                //                         ? selectedAddress.area?.price
                //                                 ?.toInt() ??
                //                             0
                //                         : selectedAddress.area?.discount
                //                                 ?.toInt() ??
                //                             0)
                //                     : 0))
                //             .toString(),
                //         price: widget.appRouterArgument.total.toString(),
                //         relationId: selectedPeriod.relationId!,
                //         shipping: shipping.isEmpty
                //             ? "0"
                //             : (discountAreas.id == -1
                //                     ? selectedAddress.area?.price?.toInt() ?? 0
                //                     : selectedAddress.area?.discount?.toInt() ??
                //                         0)
                //                 .toString(),
                //         periodId: selectedPeriod.id!,
                //         addressId: selectedAddress.id!,
                //         date: dateController.text,
                //         comment: commentController.text == ""
                //             ? null
                //             : commentController.text,
                //
                //         // todo clear cart
                //         cart: []
                //         // cart: cart,
                //         ),
                //     afterSuccess: () {
                //       NavigationService.pushReplacementNamed(
                //         Routes.success,
                //         arguments: SuccessType.order,
                //       );
                //       NotificationCubit(instance()).saveNotification(
                //         request: NotificationRequest(
                //           userId: Globals.userData.id!,
                //           title: "الطلبات",
                //           message: "تم إنشاء طلبك بنجاح و بإنتظار التأكيد",
                //         ),
                //       );
                //       // todo clear cart
                //       // cart.clear();
                //     },
                //   );
                // }
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

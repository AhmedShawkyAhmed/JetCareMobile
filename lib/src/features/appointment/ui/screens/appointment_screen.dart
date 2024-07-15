import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/arguments/appointment_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/address/cubit/address_cubit.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/ui/widgets/address_widget.dart';
import 'package:jetcare/src/features/appointment/cubit/appointment_cubit.dart';
import 'package:jetcare/src/features/appointment/data/models/period_model.dart';
import 'package:jetcare/src/features/appointment/data/models/space_model.dart';
import 'package:jetcare/src/features/appointment/ui/widgets/calender_item_view.dart';
import 'package:jetcare/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetcare/src/features/orders/data/requests/order_request.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class AppointmentScreen extends StatefulWidget {
  final AppointmentArguments arguments;

  const AppointmentScreen({
    required this.arguments,
    super.key,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  AppointmentCubit appointmentCubit = AppointmentCubit(instance());
  AddressCubit addressCubit = AddressCubit(instance());
  DateTime now = DateTime.now();
  int quantity = 1;
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  AddressModel selectedAddress = AddressModel(id: -1);
  AreaModel discountAreas = AreaModel(id: -1);
  PeriodModel selectedPeriod = PeriodModel();
  SpaceModel selectedSpace = SpaceModel();
  List<PeriodModel> discountPeriods = [];
  List<int> cart = [];

  DateTime date = DateTime.now();
  int selected = -1;

  @override
  void dispose() {
    dateController.dispose();
    quantityController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => appointmentCubit
            ..getCalendar()
            ..getPeriods(),
        ),
        BlocProvider(
          create: (context) => addressCubit..getMyAddresses(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          widget: ListView(
            children: [
              SizedBox(
                height: 2.h,
              ),
              if (Globals.userData.token != null) ...[
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
                                      month: appointmentCubit
                                                  .calendar.first.month ==
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
                                      month: appointmentCubit
                                                  .calendar.first.month ==
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
                                                        .area!
                                                        .isEmpty) {
                                                      discountAreas =
                                                          AreaModel(id: -1);
                                                    } else {
                                                      discountAreas =
                                                          appointmentCubit
                                                              .calendar[index]
                                                              .area!
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
                                                                  .calendar[
                                                                      index]
                                                                  .area!
                                                                  .first
                                                                  .id ==
                                                              selectedAddress
                                                                  .area?.id
                                                          ? widget
                                                                  .arguments
                                                                  .shipping
                                                                  .isNotEmpty
                                                              ? AppColors.gold
                                                              : null
                                                          : null
                                              : AppColors.shade
                                                  .withOpacity(0.4),
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
                                      items: widget.arguments.shipping.isEmpty
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
                          " ${widget.arguments.total} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
              if (widget.arguments.shipping.isNotEmpty) ...[
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
                          " ${((double.parse(widget.arguments.total.toString())) + (widget.arguments.shipping.isNotEmpty ? (discountAreas.id == -1 ? selectedAddress.area?.price?.toInt() ?? 0 : selectedAddress.area?.discount?.toInt() ?? 0) : 0))} ${translate(AppStrings.currency)}",
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
                  OrdersCubit(instance()).createOrder(
                    request: OrderRequest(
                      userId: Globals.userData.id!,
                      total:
                          ((double.parse(widget.arguments.total.toString())) +
                                  (widget.arguments.shipping.isNotEmpty
                                      ? (discountAreas.id == -1
                                          ? selectedAddress.area?.price
                                                  ?.toInt() ??
                                              0
                                          : selectedAddress.area?.discount
                                                  ?.toInt() ??
                                              0)
                                      : 0))
                              .toString(),
                      price: widget.arguments.total.toString(),
                      relationId: selectedPeriod.relationId,
                      shipping: widget.arguments.shipping.isEmpty
                          ? 0
                          : (discountAreas.id == -1
                              ? selectedAddress.area?.price?.toInt() ?? 0
                              : selectedAddress.area?.discount?.toInt() ?? 0),
                      periodId: selectedPeriod.id!,
                      addressId: selectedAddress.id!,
                      date: dateController.text,
                      comment: commentController.text == ""
                          ? null
                          : commentController.text,
                      cart: widget.arguments.cartIds,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

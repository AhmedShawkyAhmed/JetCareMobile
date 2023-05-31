import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/NotificationDownloadingService.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/business_logic/order_cubit/order_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/network/requests/order_request.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/address_widget.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/period_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

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

  List<bool> isChecked = List.generate(2000, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            SizedBox(
              height: 5.h,
            ),
            InkWell(
              onTap: () {
                selectDate(context);
              },
              child: DefaultTextField(
                controller: dateController,
                marginHorizontal: 15.w,
                height: 5.h,
                hintText: translate(AppStrings.orderDate),
                enabled: false,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            if (CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.password) !=
                null) ...[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: DefaultText(
                      text: translate(AppStrings.chooseAddress),
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 10.h,
                child: BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    if (AddressCubit.get(context).addressList.isEmpty ||
                        AddressCubit.get(context).addressResponse == null) {
                      return Center(
                        child: DefaultText(
                          text: translate(AppStrings.aAddress),
                          textColor: AppColors.pc,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouterNames.addAddress,
                              arguments: AppRouterArgument(type: "new"),
                            );
                          },
                        ),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
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
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: DefaultText(
                    text: translate(AppStrings.chooseTime),
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 7.h,
              child: BlocBuilder<GlobalCubit, GlobalState>(
                builder: (context, state) {
                  if (GlobalCubit.get(context).periodResponse?.periods ==
                      null) {
                    return const SizedBox();
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    itemCount: GlobalCubit.get(context)
                        .periodResponse!
                        .periods!
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedPeriod = GlobalCubit.get(context)
                                .periodResponse!
                                .periods![index];
                          });
                        },
                        child: PeriodView(
                          color: selectedPeriod.id ==
                                  GlobalCubit.get(context)
                                      .periodResponse!
                                      .periods![index]
                                      .id
                              ? AppColors.pc.withOpacity(0.5)
                              : AppColors.shade.withOpacity(0.1),
                          from: GlobalCubit.get(context)
                                  .periodResponse!
                                  .periods![index]
                                  .from ??
                              "",
                          to: GlobalCubit.get(context)
                                  .periodResponse!
                                  .periods![index]
                                  .to ??
                              "",
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            DefaultTextField(
              controller: commentController,
              hintText: translate(AppStrings.addComment),
              maxLine: 10,
              height: 15.h,
              maxLength: 500,
            ),
            if (shipping.isNotEmpty) ...[
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    DefaultText(
                      text: translate(AppStrings.shipping),
                    ),
                    const Spacer(),
                    DefaultText(
                      text: selectedAddress.area == null ||
                              selectedAddress.area!.price!.toInt() == 0
                          ? translate(AppStrings.free)
                          : " ${selectedAddress.area!.price!.toInt()} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
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
                          " ${((double.parse(widget.appRouterArgument.total.toString())) + (selectedAddress.area == null || selectedAddress.area!.price!.toInt() == 0 ? 0 : selectedAddress.area!.price!.toDouble())).toInt()} ${translate(AppStrings.currency)}",
                    ),
                  ],
                ),
              ),
            ],
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
                      total: shipping.isEmpty
                          ? widget.appRouterArgument.total.toString()
                          : ((double.parse(widget.appRouterArgument.total
                                      .toString())) +
                                  (selectedAddress.area == null ||
                                          selectedAddress.area!.price!
                                                  .toInt() ==
                                              0
                                      ? 0
                                      : selectedAddress.area!.price!
                                          .toDouble()))
                              .toString(),
                      price: widget.appRouterArgument.total.toString(),
                      shipping: shipping.isEmpty
                          ? "0"
                          : (selectedAddress.area == null ||
                                      selectedAddress.area!.price!.toInt() == 0
                                  ? 0
                                  : selectedAddress.area!.price!.toInt())
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

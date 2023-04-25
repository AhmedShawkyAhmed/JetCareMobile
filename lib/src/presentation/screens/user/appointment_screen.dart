import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/network/requests/order_summery.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/address_widget.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
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
                null)
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
            if (CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.password) !=
                null)
              SizedBox(
                height: 2.h,
              ),
            if (CacheHelper.getDataFromSharedPreference(
                    key: SharedPreferenceKeys.password) !=
                null)
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
            if (widget.appRouterArgument.type == "package") ...[
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: DefaultText(
                      text: "${translate(AppStrings.enterSpace)} M²",
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTextField(
                    width: 90.w,
                    marginVertical: 0,
                    marginHorizontal: 5.w,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    hintText: translate(AppStrings.orderSpace),
                    onChange: (value) {
                      setState(() {
                        printError(value);
                        quantity = int.parse(value == "" ? "1" : value);
                      });
                    },
                  ),
                ],
              )
            ],
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: DefaultText(
                    text: translate(AppStrings.addExtra),
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            GlobalCubit.get(context).homeResponse?.extraModel == null
                ? SizedBox(
                    height: 50.h,
                    child: Center(
                      child: DefaultText(
                        text: translate(AppStrings.noExtras),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 14.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(5.w),
                      itemCount: GlobalCubit.get(context)
                          .homeResponse!
                          .extraModel!
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            isChecked[index] = !isChecked[index];
                            isChecked[index]
                                ? {
                                    selectedExtra.add(GlobalCubit.get(context)
                                        .homeResponse!
                                        .extraModel![index]),
                                    extrasIds.add(GlobalCubit.get(context)
                                        .homeResponse!
                                        .extraModel![index]
                                        .id!),
                                    extrasPrice = extrasPrice +
                                        GlobalCubit.get(context)
                                            .homeResponse!
                                            .extraModel![index]
                                            .price!,
                                  }
                                : {
                                    selectedExtra.remove(
                                        GlobalCubit.get(context)
                                            .homeResponse!
                                            .extraModel![index]),
                                    extrasIds.remove(GlobalCubit.get(context)
                                        .homeResponse!
                                        .extraModel![index]
                                        .id!),
                                    extrasPrice = extrasPrice -
                                        GlobalCubit.get(context)
                                            .homeResponse!
                                            .extraModel![index]
                                            .price!,
                                  };
                            setState(() {
                              printResponse(extrasPrice.toString());
                            });
                          },
                          child: Container(
                            width: 40.w,
                            height: 3.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 0.5.h, horizontal: 2.w),
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5.h,
                              horizontal: 1.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.shade.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DefaultText(
                                        text: CacheHelper
                                                    .getDataFromSharedPreference(
                                                        key:
                                                            SharedPreferenceKeys
                                                                .language) ==
                                                "ar"
                                            ? GlobalCubit.get(context)
                                                    .homeResponse!
                                                    .extraModel![index]
                                                    .nameAr ??
                                                ""
                                            : GlobalCubit.get(context)
                                                    .homeResponse!
                                                    .extraModel![index]
                                                    .nameEn ??
                                                "",
                                        textColor: AppColors.white,
                                        fontSize: 12.sp,
                                      ),
                                      DefaultText(
                                        text:
                                            "${GlobalCubit.get(context).homeResponse!.extraModel![index].price ?? ""} ${translate(AppStrings.currency)}",
                                        textColor: AppColors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                  child: Checkbox(
                                    value: selectedExtra.contains(
                                            GlobalCubit.get(context)
                                                .homeResponse!
                                                .extraModel![index])
                                        ? true
                                        : isChecked[index],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    onChanged: (value) {},
                                    activeColor: AppColors.pc,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  text:
                      "${((widget.appRouterArgument.packageModel == null ? widget.appRouterArgument.itemModel!.price : widget.appRouterArgument.packageModel!.price)!.toInt() * quantity) + (extrasPrice).toInt()} ${translate(AppStrings.currency)}",
                  maxLines: 1,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            CacheHelper.getDataFromSharedPreference(
                        key: SharedPreferenceKeys.password) ==
                    null
                ? DefaultAppButton(
                    title: translate(AppStrings.loginFirst),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouterNames.login,
                        (route) => false,
                      );
                    },
                  )
                : DefaultAppButton(
                    title: translate(AppStrings.con),
                    onTap: () {
                      orderSummery.clear();
                      if (dateController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.selectData));
                      } else if (selectedAddress.id == 0) {
                        DefaultToast.showMyToast(
                            translate(AppStrings.selectAddress));
                      } else if (selectedPeriod.id == 0) {
                        DefaultToast.showMyToast(
                            translate(AppStrings.selectTime));
                      }  else if (quantity < 10 && widget.appRouterArgument.type == "package") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterSpace));
                      }else {
                        orderSummery.insert(
                          0,
                          OrderSummery(
                            key: AppStrings.order,
                            value: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
                                ? "${widget.appRouterArgument.packageModel == null ? widget.appRouterArgument.itemModel!.nameAr : widget.appRouterArgument.packageModel!.nameAr}"
                                : "${widget.appRouterArgument.packageModel == null ? widget.appRouterArgument.itemModel!.nameEn : widget.appRouterArgument.packageModel!.nameEn}",
                          ),
                        );
                        orderSummery.insert(
                          1,
                          OrderSummery(
                            key: AppStrings.orderAddress,
                            value:
                                "${selectedAddress.floor}, ${selectedAddress.building}, ${selectedAddress.street}, ${selectedAddress.area}, ${selectedAddress.district}",
                          ),
                        );
                        orderSummery.insert(
                          2,
                          OrderSummery(
                            key: AppStrings.orderPhone,
                            value: "${selectedAddress.phone}",
                          ),
                        );
                        orderSummery.insert(
                          3,
                          OrderSummery(
                            key: AppStrings.orderDate,
                            value: dateController.text,
                          ),
                        );
                        orderSummery.insert(
                          4,
                          OrderSummery(
                            key: AppStrings.orderTime,
                            value:
                                "${selectedPeriod.from} - ${selectedPeriod.to}",
                          ),
                        );
                        orderSummery.insert(
                          5,
                          OrderSummery(
                            key: AppStrings.orderSpace,
                            value:
                                "$quantity M²",
                          ),
                        );
                        orderSummery.insert(
                          6,
                          OrderSummery(
                            key: AppStrings.count,
                            value:
                                "${widget.appRouterArgument.itemModel?.quantity} - ${widget.appRouterArgument.itemModel?.unit}",
                          ),
                        );
                        orderSummery.insert(
                          7,
                          OrderSummery(
                            key: AppStrings.price,
                            value:
                                "${((widget.appRouterArgument.packageModel == null ? widget.appRouterArgument.itemModel!.price : widget.appRouterArgument.packageModel!.price)!.toInt() * quantity) } ${translate(AppStrings.currency)}",
                          ),
                        );
                        if (selectedExtra.isNotEmpty) {
                          for (int i = 0; i < selectedExtra.length; i++) {
                            orderSummery.insert(
                              i + 8,
                              OrderSummery(
                                key: CacheHelper.getDataFromSharedPreference(
                                            key: SharedPreferenceKeys
                                                .language) ==
                                        "ar"
                                    ? "${selectedExtra[i].nameAr}"
                                    : "${selectedExtra[i].nameEn}",
                                value:
                                    "${selectedExtra[i].price} ${translate(AppStrings.currency)}",
                              ),
                            );
                          }
                        }
                        orderSummery.insert(
                          selectedExtra.length + 8,
                          OrderSummery(
                            key: AppStrings.total,
                            value:
                                "${((widget.appRouterArgument.packageModel == null ? widget.appRouterArgument.itemModel!.price : widget.appRouterArgument.packageModel!.price)!.toInt() * quantity) + (extrasPrice).toInt()}",
                          ),
                        );
                        if (widget.appRouterArgument.type == "item") {
                          orderSummery.removeAt(5);
                        }
                        if (widget.appRouterArgument.type == "package") {
                          orderSummery.removeAt(6);
                        }
                        Navigator.pushNamed(
                          context,
                          AppRouterNames.confirmOrder,
                          arguments: widget.appRouterArgument,
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

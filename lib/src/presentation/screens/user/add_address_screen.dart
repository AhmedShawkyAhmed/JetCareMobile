import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/data/network/requests/address_request.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/widgets/default_app_button.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/default_text_field.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class AddAddressScreen extends StatefulWidget {
  final AppRouterArgument appRouterArguments;

  const AddAddressScreen({
    required this.appRouterArguments,
    Key? key,
  }) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  @override
  dispose() {
    phoneController.clear();
    floorController.clear();
    buildingController.clear();
    streetController.clear();
    areaController.clear();
    districtController.clear();
    addressLocation = const LatLng(0.0, 0.0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        widget: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: DefaultText(
                    text: translate(AppStrings.addAddress),
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            DefaultTextField(
              controller: phoneController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.phone!
                  : translate(AppStrings.phone),
              keyboardType: TextInputType.phone,
            ),
            DefaultTextField(
              controller: floorController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.floor.toString()
                  : translate(AppStrings.floor),
              keyboardType: TextInputType.number,
            ),
            DefaultTextField(
              controller: buildingController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.building!
                  : translate(AppStrings.building),
            ),
            DefaultTextField(
              controller: streetController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.street!
                  : translate(AppStrings.street),
            ),
            DefaultTextField(
              controller: areaController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.area!
                  : translate(AppStrings.area),
            ),
            DefaultTextField(
              controller: districtController,
              hintText: widget.appRouterArguments.type == "edit"
                  ? widget.appRouterArguments.addressModel!.district!
                  : translate(AppStrings.district),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextField(
                    marginHorizontal: 3.w,
                    width: 66.w,
                    controller: locationController,
                    enabled: false,
                    hintText: addressLocation.latitude == 0.0
                        ? widget.appRouterArguments.type == "edit"
                            ? "${widget.appRouterArguments.addressModel!.latitude!}, ${widget.appRouterArguments.addressModel!.longitude!}"
                            : translate(AppStrings.location)
                        : "${addressLocation.latitude}, ${addressLocation.longitude}",
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouterNames.map);
                    },
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                          color: AppColors.pc,
                          borderRadius: BorderRadius.circular(6)),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: AppColors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            widget.appRouterArguments.type == "edit"
                ? DefaultAppButton(
                    title: translate(AppStrings.save),
                    onTap: () {
                      IndicatorView.showIndicator(context);
                                Navigator.pop(context);
                      AddressCubit.get(context).updateAddress(
                        addressRequest: AddressRequest(
                          userId: widget.appRouterArguments.addressModel!.id!,
                          phone: phoneController.text,
                          floor: floorController.text,
                          building: buildingController.text,
                          street: streetController.text,
                          area: areaController.text,
                          district: districtController.text,
                          latitude: addressLocation.latitude.toString(),
                          longitude: addressLocation.longitude.toString(),
                        ),
                        afterSuccess: () {
                          AddressCubit.get(context).getMyAddresses(
                              afterSuccess: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                  )
                : DefaultAppButton(
                    title: translate(AppStrings.aAddress),
                    onTap: () {
                      if (phoneController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterPhone));
                      } else if (floorController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterFloor));
                      } else if (buildingController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterBuilding));
                      } else if (streetController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterStreet));
                      } else if (areaController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterArea));
                      } else if (districtController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterDistrict));
                      } else if (locationController.text == "") {
                        DefaultToast.showMyToast(
                            translate(AppStrings.enterLocation));
                      } else {
                        IndicatorView.showIndicator(context);
                                Navigator.pop(context);
                        AddressCubit.get(context).addAddress(
                          addressRequest: AddressRequest(
                            userId: globalAccountModel.id!,
                            phone: phoneController.text,
                            floor: floorController.text,
                            building: buildingController.text,
                            street: streetController.text,
                            area: areaController.text,
                            district: districtController.text,
                            latitude: addressLocation.latitude.toString(),
                            longitude: addressLocation.longitude.toString(),
                          ),
                          afterSuccess: () {
                            AddressCubit.get(context).getMyAddresses(
                                afterSuccess: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/features/address/cubit/address_cubit.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/data/models/area_model.dart';
import 'package:jetcare/src/features/address/data/requests/address_request.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_drop_down_menu.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;

  const AddAddressScreen({
    required this.address,
    super.key,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late AddressCubit cubit = BlocProvider.of(context);
   TextEditingController phoneController = TextEditingController();
   TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  int stateId = 0;
  int areaId = 0;

  @override
  dispose() {
    phoneController.clear();
    addressController.clear();
    locationController.clear();
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
              hintText: widget.address != null
                  ? widget.address!.phone!
                  : translate(AppStrings.phone),
              keyboardType: TextInputType.phone,
            ),
            DefaultTextField(
              controller: addressController,
              hintText: widget.address != null
                  ? widget.address!.address!
                  : translate(AppStrings.orderAddress),
            ),
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                return cubit.states.isEmpty
                    ? const SizedBox()
                    : Container(
                        height: 5.h,
                        width: 100.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: DefaultDropdown<AreaModel>(
                          hint: translate(AppStrings.state),
                          showSearchBox: true,
                          itemAsString: (AreaModel? u) => u?.nameAr ?? "",
                          items: cubit.states,
                          onChanged: (val) {
                            setState(() {
                              stateId = val!.id!;
                              cubit.getAreasOfState(stateId: stateId);
                            });
                          },
                        ),
                      );
              },
            ),
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                return cubit.areas.isEmpty
                    ? const SizedBox()
                    : Container(
                        height: 5.h,
                        width: 100.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: DefaultDropdown<AreaModel>(
                          hint: translate(AppStrings.area),
                          showSearchBox: true,
                          itemAsString: (AreaModel? u) => u?.nameAr ?? "",
                          items: cubit.areas,
                          onChanged: (val) {
                            setState(() {
                              areaId = val!.id!;
                            });
                          },
                        ),
                      );
              },
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
                        ? widget.address != null
                            ? "${widget.address!.latitude!}, ${widget.address!.longitude!}"
                            : translate(AppStrings.location)
                        : "${addressLocation.latitude}, ${addressLocation.longitude}",
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.pushNamed(Routes.map);
                    },
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
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
            widget.address != null
                ? DefaultAppButton(
                    title: translate(AppStrings.save),
                    onTap: () {
                      AddressCubit(instance()).updateAddress(
                        request: AddressRequest(
                          id: widget.address!.id!,
                          userId: Globals.userData.id,
                          phone: phoneController.text,
                          address: addressController.text,
                          stateId: stateId,
                          areaId: areaId,
                          latitude: addressLocation.latitude.toString(),
                          longitude: addressLocation.longitude.toString(),
                        ),
                      );
                    },
                  )
                : DefaultAppButton(
                    title: translate(AppStrings.aAddress),
                    onTap: () {
                      AddressCubit(instance()).addAddress(
                        request: AddressRequest(
                          userId: Globals.userData.id!,
                          phone: phoneController.text,
                          address: addressController.text,
                          stateId: stateId,
                          areaId: areaId,
                          latitude: addressLocation.latitude.toString(),
                          longitude: addressLocation.longitude.toString(),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

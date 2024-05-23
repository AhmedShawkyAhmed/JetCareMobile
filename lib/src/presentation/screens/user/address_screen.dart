import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/core/shared/widgets/default_text.dart';
import 'package:jetcare/src/presentation/views/address_widget.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        child: const Center(
          child: Icon(
            Icons.refresh_outlined,
            color: AppColors.primary,
          ),
        ),
        onPressed: () {
          AddressCubit(instance()).getMyAddresses(afterSuccess: () {});
        },
      ),
      body: BodyView(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DefaultAppButton(
                  width: 40.w,
                  marginHorizontal: 1.w,
                  marginVertical: 0,
                  height: 5.h,
                  title: translate(AppStrings.addAddress),
                  onTap: () {
                    IndicatorView.showIndicator(context);
                    AddressCubit(instance()).getAllStates(afterSuccess: () {
                      NavigationService.pop();
                      NavigationService.pushNamed(
                        AppRouterNames.addAddress,
                        arguments: AppRouterArgument(type: "new"),
                      );
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoadingState) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return LoadingView(
                        height: 10.h,
                      );
                    });
                  } else if (AddressCubit(instance()).addressList.isEmpty) {
                    return Center(
                      child: DefaultText(
                        text: translate(AppStrings.noAddress),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    itemCount: AddressCubit(instance()).addressCount,
                    itemBuilder: (context, index) {
                      return AddressWidget(
                        addressModelList: const [],
                        addressModel:
                            AddressCubit(instance()).addressList[index],
                        delete: () {
                          AddressCubit(instance()).deleteAddress(
                              address:
                                  AddressCubit(instance()).addressList[index]);
                        },
                        edit: () {
                          NavigationService.pushNamed(
                            AppRouterNames.addAddress,
                            arguments: AppRouterArgument(
                              type: "edit",
                              addressModel:
                                  AddressCubit(instance()).addressList[index],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

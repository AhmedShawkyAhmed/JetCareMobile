import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/address_widget.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

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
            color: AppColors.pc,
          ),
        ),
        onPressed: () {
          AddressCubit.get(context).getMyAddresses(afterSuccess: () {});
        },
      ),
      body: BodyView(
        widget: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.h,
                  ),
                  child: DefaultText(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouterNames.addAddress,
                        arguments: AppRouterArgument(type: "new"),
                      );
                    },
                    text: translate(AppStrings.addAddress),
                    fontSize: 12.sp,
                  ),
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
                  } else if (AddressCubit.get(context).addressList.isEmpty) {
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
                    itemCount: AddressCubit.get(context).addressCount,
                    itemBuilder: (context, index) {
                      return AddressWidget(
                        addressModelList: const [],
                        addressModel:
                            AddressCubit.get(context).addressList[index],
                        delete: () {
                          AddressCubit.get(context).deleteAddress(
                              address:
                                  AddressCubit.get(context).addressList[index]);
                        },
                        edit: () {
                          Navigator.pushNamed(
                            context,
                            AppRouterNames.addAddress,
                            arguments: AppRouterArgument(
                              type: "edit",
                              addressModel:
                                  AddressCubit.get(context).addressList[index],
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

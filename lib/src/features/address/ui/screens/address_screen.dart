import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/address/cubit/address_cubit.dart';
import 'package:jetcare/src/features/address/ui/widgets/address_widget.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_app_button.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressCubit cubit = BlocProvider.of(context);

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
          cubit.getMyAddresses();
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
                    NavigationService.pushNamed(
                      Routes.addAddress,
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is GetAddressLoading) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return LoadingView(
                          height: 10.h,
                        );
                      },
                    );
                  } else if (cubit.address.isEmpty) {
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
                    itemCount: cubit.address.length,
                    itemBuilder: (context, index) {
                      return AddressWidget(
                        addressModelList: const [],
                        addressModel: cubit.address[index],
                        delete: () {
                          cubit.deleteAddress(id: cubit.address[index].id!);
                        },
                        edit: () {
                          NavigationService.pushNamed(
                            Routes.addAddress,
                            arguments: cubit.address[index],
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

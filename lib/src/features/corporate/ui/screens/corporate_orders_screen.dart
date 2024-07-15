import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/corporate/cubit/corporate_cubit.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CorporateOrdersScreen extends StatefulWidget {
  const CorporateOrdersScreen({super.key});

  @override
  State<CorporateOrdersScreen> createState() => _CorporateOrdersScreenState();
}

class _CorporateOrdersScreenState extends State<CorporateOrdersScreen> {
  CorporateCubit cubit = CorporateCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getMyCorporateOrders(),
      child: BlocBuilder<CorporateCubit, CorporateState>(
        builder: (context, state) {
          if (state is GetCorporateOrdersLoading) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LoadingView(
                  height: 10.h,
                );
              },
            );
          }
          return cubit.corporates.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.only(left: 3.w, right: 3.w),
                  itemCount: cubit.corporates.length,
                  itemBuilder: (context, index) {
                    return CardView(
                      title: isArabic
                          ? cubit.corporates[index].item!.nameAr
                          : cubit.corporates[index].item!.nameEn,
                      image: cubit.corporates[index].item!.image,
                      height: 15.h,
                      mainHeight: 20.h,
                      titleFont: 17.sp,
                      colorMain: AppColors.primary.withOpacity(0.8),
                      colorSub: AppColors.shade.withOpacity(0.4),
                      onTap: () {
                        NavigationService.pushNamed(
                          Routes.corporateDetails,
                          arguments: cubit.corporates[index],
                        );
                      },
                    );
                  },
                )
              : Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: DefaultText(
                    text: translate(AppStrings.noOrders),
                  ),
                );
        },
      ),
    );
  }
}

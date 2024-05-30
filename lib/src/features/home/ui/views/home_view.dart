import 'package:flutter/material.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/arguments/home_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/home/cubit/home_cubit.dart';
import 'package:jetcare/src/features/home/data/models/item_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/shared/ui/views/loading_view.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final String title;
  final HomeViewType type;
  final bool visible;
  final List<PackageModel>? packageList;
  final List<ItemModel>? itemList;
  final double? paddingWidth;

  const HomeView({
    required this.title,
    required this.type,
    required this.visible,
    this.packageList,
    this.itemList,
    this.paddingWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return visible
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: paddingWidth ?? 3.w,
                  right: paddingWidth ?? 3.w,
                  bottom: 1.h,
                  top: 2.h,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp,
                  ),
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: (20.w / 12.h),
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return packageList == null && itemList == null
                        ? LoadingView(
                            width: 90.w,
                            height: 15.h,
                          )
                        : CardView(
                            onTap: () {
                              if (type == HomeViewType.corporate) {
                                NavigationService.pushNamed(
                                  Routes.corporate,
                                  arguments: HomeArguments(
                                    item: itemList![index],
                                  ),
                                );
                              } else if (type == HomeViewType.category) {
                                HomeCubit(instance()).getCategoryDetails(
                                  id: packageList![index].id!,
                                );
                              } else if (type == HomeViewType.package) {
                                HomeCubit(instance()).getPackageDetails(
                                  id: packageList![index].id!,
                                );
                              } else if (type == HomeViewType.extra) {
                                NavigationService.pushNamed(
                                  Routes.service,
                                  arguments: HomeArguments(
                                    item: itemList![index],
                                  ),
                                );
                              }
                            },
                            colorMain: AppColors.primary.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            title: isArabic
                                ? packageList == null
                                    ? itemList![index].nameAr
                                    : packageList![index].nameAr
                                : packageList == null
                                    ? itemList![index].nameEn
                                    : packageList![index].nameEn,
                            titleFont: 8.sp,
                            image: packageList == null
                                ? itemList![index].image
                                : packageList![index].image,
                          );
                  },
                  itemCount: type == HomeViewType.loading
                      ? 10
                      : packageList == null
                          ? itemList!.length
                          : packageList!.length,
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}

import 'package:flutter/material.dart';
import 'package:jetcare/src/business_logic/details_cubit/details_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/shared_preference_keys.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/services/cache_service.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/data/models/item_model.dart';
import 'package:jetcare/src/data/models/package_model.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/loading_view.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final String title, type;
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
                              IndicatorView.showIndicator(context);
                              if (type == "corporate") {
                                NavigationService.pop();
                                NavigationService.pushNamed(
                                  Routes.corporate,
                                  arguments: AppRouterArgument(
                                    itemModel: itemList![index],
                                  ),
                                );
                              } else if (type == "category") {
                                DetailsCubit(instance()).getCategory(
                                  id: packageList![index].id!,
                                  afterSuccess: () {
                                    NavigationService.pop();
                                    NavigationService.pushNamed(
                                      Routes.categoryDetails,
                                    );
                                  },
                                );
                              } else if (type == "package") {
                                DetailsCubit(instance()).getPackage(
                                  id: packageList![index].id!,
                                  afterSuccess: () {
                                    NavigationService.pop();
                                    NavigationService.pushNamed(
                                      Routes.packageDetails,
                                    );
                                  },
                                );
                              } else if (type == "extra") {
                                NavigationService.pop();
                                NavigationService.pushNamed(
                                  Routes.serviceDetails,
                                  arguments: AppRouterArgument(
                                    itemModel: itemList![index],
                                  ),
                                );
                              }
                            },
                            colorMain: AppColors.primary.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            title: CacheService.get(
                                        key: CacheKeys.language) ==
                                    "ar"
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
                  itemCount: type == "loading"
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

import 'package:flutter/cupertino.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/arguments/home_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:sizer/sizer.dart';

class ServiceView extends StatelessWidget {
  final String title;
  final List<PackageModel> packageList;

  const ServiceView({
    required this.title,
    required this.packageList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: packageList.isEmpty ? false : true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 3.w,
              right: 3.w,
              bottom: 2.h,
              top: 1.h,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: 150,
              ),
              scrollDirection: Axis.vertical,
              itemCount: packageList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Text(
                        isArabic
                            ? packageList[index].nameAr.toString()
                            : packageList[index].nameEn.toString(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 15.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: packageList[index].items!.length,
                        itemBuilder: (context, position) {
                          return CardView(
                            onTap: () {
                              NavigationService.pushNamed(
                                Routes.serviceItems,
                                arguments: HomeArguments(
                                  item: packageList[index].items![position],
                                ),
                              );
                            },
                            width: 32.w,
                            colorMain: AppColors.primary.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            title: isArabic
                                ? packageList[index].items![position].nameAr
                                : packageList[index].items![position].nameEn,
                            titleFont: 10.sp,
                            image: packageList[index].items![position].image,
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

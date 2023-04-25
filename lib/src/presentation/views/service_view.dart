import 'package:flutter/cupertino.dart';
import 'package:jetcare/src/constants/shared_preference_keys.dart';
import 'package:jetcare/src/data/data_provider/local/cache_helper.dart';
import 'package:jetcare/src/data/models/package_model.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/card_view.dart';
import 'package:sizer/sizer.dart';

class ServiceView extends StatelessWidget {
  final String title;
  final List<PackageModel> packageList;

  const ServiceView({
    required this.title,
    required this.packageList,
    Key? key,
  }) : super(key: key);

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
                        CacheHelper.getDataFromSharedPreference(
                                    key: SharedPreferenceKeys.language) ==
                                "ar"
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
                              Navigator.pushNamed(
                                context,
                                AppRouterNames.serviceDetails,
                                arguments: AppRouterArgument(
                                  itemModel:
                                      packageList[index].items![position],
                                ),
                              );
                            },
                            width: 32.w,
                            colorMain: AppColors.pc.withOpacity(0.8),
                            colorSub: AppColors.shade.withOpacity(0.4),
                            title: CacheHelper.getDataFromSharedPreference(
                                        key: SharedPreferenceKeys.language) ==
                                    "ar"
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/core/shared/globals.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/home/cubit/home_cubit.dart';
import 'package:jetcare/src/features/home/ui/views/card_view.dart';
import 'package:jetcare/src/features/home/ui/views/home_view.dart';
import 'package:jetcare/src/features/home/ui/views/service_view.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit cubit = BlocProvider.of(context);

  @override
  void initState() {
    cubit.getHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: BodyView(
        hasBack: false,
        widget: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetHomeLoading) {
              return ListView(
                children: [
                  if (Globals.userData.name != null) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        top: 2.h,
                        bottom: 2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultText(
                            text: Globals.userData.name!,
                            fontSize: 15.sp,
                          ),
                          InkWell(
                            onTap: () {
                              NavigationService.pushNamed(
                                Routes.notification,
                              );
                            },
                            child: Container(
                              width: 9.w,
                              height: 9.w,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.notifications_active,
                                  color: AppColors.primary,
                                  size: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  HomeView(
                    title: translate(AppStrings.corporate),
                    type: HomeViewType.loading,
                    visible: true,
                  ),
                ],
              );
            }
            return ListView(
              padding: EdgeInsets.only(bottom: 4.h),
              children: [
                if (Globals.userData.name != null) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DefaultText(
                          text: Globals.userData.name!,
                          fontSize: 15.sp,
                        ),
                        InkWell(
                          onTap: () {
                            NavigationService.pushNamed(
                              Routes.notification,
                            );
                          },
                          child: Container(
                            width: 9.w,
                            height: 9.w,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications_active,
                                color: AppColors.primary,
                                size: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (cubit.home?.ads != null)
                  CarouselSlider.builder(
                    itemCount: cubit.home!.ads!.length,
                    itemBuilder: (BuildContext context, int position,
                            int pageViewIndex) =>
                        Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: CardView(
                        height: 18.h,
                        onTap: () {
                          if (cubit.home!.ads![position].link == null) {
                            DefaultToast.showMyToast(
                                translate(AppStrings.adLink));
                          } else {
                            openUrl(
                              cubit.home!.ads![position].link.toString(),
                            );
                          }
                        },
                        image: cubit.home!.ads![position].image.toString(),
                      ),
                    ),
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      viewportFraction: 1,
                      height: cubit.home!.ads!.isEmpty ? 0 : 22.h,
                    ),
                  ),
                HomeView(
                  title: translate(AppStrings.corporate),
                  type: HomeViewType.corporate,
                  visible: cubit.home?.corporate?.isNotEmpty ?? false,
                  itemList: cubit.home!.corporate,
                ),
                HomeView(
                  title: translate(AppStrings.service),
                  type: HomeViewType.category,
                  visible: cubit.home?.categories?.isNotEmpty ?? false,
                  packageList: cubit.home!.categories,
                ),
                HomeView(
                  title: translate(AppStrings.offers),
                  type: HomeViewType.package,
                  visible: cubit.home?.packages?.isNotEmpty ?? false,
                  packageList: cubit.home!.packages,
                ),
                HomeView(
                  title: translate(AppStrings.extras),
                  type: HomeViewType.extra,
                  visible: cubit.home?.extras?.isNotEmpty ?? false,
                  itemList: cubit.home!.extras,
                ),
                ServiceView(
                  title: translate(AppStrings.service),
                  packageList: cubit.home!.services!,
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

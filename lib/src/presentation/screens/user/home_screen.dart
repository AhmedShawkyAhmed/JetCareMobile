import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/constants/constants_variables.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/shared/widgets/toast.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/presentation/views/home_view.dart';
import 'package:jetcare/src/features/shared/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/service_view.dart';
import 'package:sizer/sizer.dart';

import '../../views/card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit(instance())..getHome(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: BlocBuilder<GlobalCubit, GlobalState>(
            builder: (context, state) {
              if (state is HomeLoadingState || state is HomeErrorState) {
                return HomeView(
                  title: translate(AppStrings.corporate),
                  type: "loading",
                  visible: true,
                );
              }
              return ListView(
                padding: EdgeInsets.only(bottom: 4.h),
                children: [
                  if (globalAccountModel.name != null) ...[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultText(
                            text: globalAccountModel.name ?? "زائر",
                            fontSize: 15.sp,
                          ),
                          InkWell(
                            onTap: () {
                              IndicatorView.showIndicator();
                              NotificationCubit(instance()).getNotifications(
                                userId: globalAccountModel.id!,
                                afterSuccess: () {
                                  NavigationService.pop();
                                  NavigationService.pushNamed(
                                    Routes.notification,
                                  );
                                },
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
                  if (GlobalCubit(instance()).homeResponse?.adsModel != null)
                    CarouselSlider.builder(
                      itemCount: GlobalCubit(instance())
                              .homeResponse
                              ?.adsModel
                              ?.length ??
                          0,
                      itemBuilder: (BuildContext context, int position,
                              int pageViewIndex) =>
                          Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: CardView(
                          height: 18.h,
                          onTap: () {
                            if (GlobalCubit(instance())
                                    .homeResponse!
                                    .adsModel?[position]
                                    .link ==
                                null) {
                              DefaultToast.showMyToast(
                                  translate(AppStrings.adLink));
                            } else {
                              openUrl(
                                GlobalCubit(instance())
                                    .homeResponse!
                                    .adsModel![position]
                                    .link
                                    .toString(),
                              );
                            }
                          },
                          image: GlobalCubit(instance())
                              .homeResponse!
                              .adsModel![position]
                              .image
                              .toString(),
                        ),
                      ),
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        viewportFraction: 1,
                        height: GlobalCubit(instance())
                                .homeResponse!
                                .adsModel!
                                .isEmpty
                            ? 0
                            : 22.h,
                      ),
                    ),
                  HomeView(
                    title: translate(AppStrings.corporate),
                    type: "corporate",
                    visible: GlobalCubit(instance())
                        .homeResponse!
                        .corporateModel!
                        .isNotEmpty,
                    itemList:
                        GlobalCubit(instance()).homeResponse!.corporateModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.service),
                    type: "category",
                    visible: GlobalCubit(instance())
                        .homeResponse!
                        .categoryModel!
                        .isNotEmpty,
                    packageList:
                        GlobalCubit(instance()).homeResponse!.categoryModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.offers),
                    type: "package",
                    visible: GlobalCubit(instance())
                        .homeResponse!
                        .packageModel!
                        .isNotEmpty,
                    packageList:
                        GlobalCubit(instance()).homeResponse!.packageModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.extras),
                    type: "extra",
                    visible: GlobalCubit(instance())
                        .homeResponse!
                        .extraModel!
                        .isNotEmpty,
                    itemList: GlobalCubit(instance()).homeResponse!.extraModel,
                  ),
                  ServiceView(
                    title: translate(AppStrings.service),
                    packageList:
                        GlobalCubit(instance()).homeResponse!.serviceModel!,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

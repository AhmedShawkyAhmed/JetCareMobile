import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetcare/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/constants/constants_variables.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';
import 'package:jetcare/src/presentation/views/body_view.dart';
import 'package:jetcare/src/presentation/views/home_view.dart';
import 'package:jetcare/src/presentation/views/indicator_view.dart';
import 'package:jetcare/src/presentation/views/service_view.dart';
import 'package:jetcare/src/presentation/widgets/default_text.dart';
import 'package:jetcare/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../views/card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalCubit()..getHome(),
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
                  if(globalAccountModel.name != null)...[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultText(
                            text: globalAccountModel.name??"زائر",
                            fontSize: 15.sp,
                          ),
                          InkWell(
                            onTap: () {
                              IndicatorView.showIndicator(context);
                              NotificationCubit.get(context).getNotifications(
                                userId: globalAccountModel.id!,
                                afterSuccess: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterNames.notification,
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
                                  color: AppColors.pc,
                                  size: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (GlobalCubit.get(context).homeResponse?.adsModel != null)
                    CarouselSlider.builder(
                      itemCount: GlobalCubit.get(context)
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
                            if (GlobalCubit.get(context)
                                    .homeResponse!
                                    .adsModel?[position]
                                    .link ==
                                null) {
                              DefaultToast.showMyToast(
                                  translate(AppStrings.adLink));
                            } else {
                              GlobalCubit.get(context).openUrl(
                                GlobalCubit.get(context)
                                    .homeResponse!
                                    .adsModel![position]
                                    .link
                                    .toString(),
                              );
                            }
                          },
                          image: GlobalCubit.get(context)
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
                        height: GlobalCubit.get(context)
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
                    visible: GlobalCubit.get(context)
                        .homeResponse!
                        .corporateModel!
                        .isNotEmpty,
                    itemList:
                        GlobalCubit.get(context).homeResponse!.corporateModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.service),
                    type: "category",
                    visible: GlobalCubit.get(context)
                        .homeResponse!
                        .categoryModel!
                        .isNotEmpty,
                    packageList:
                        GlobalCubit.get(context).homeResponse!.categoryModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.offers),
                    type: "package",
                    visible: GlobalCubit.get(context)
                        .homeResponse!
                        .packageModel!
                        .isNotEmpty,
                    packageList:
                        GlobalCubit.get(context).homeResponse!.packageModel,
                  ),
                  HomeView(
                    title: translate(AppStrings.extras),
                    type: "extra",
                    visible: GlobalCubit.get(context)
                        .homeResponse!
                        .extraModel!
                        .isNotEmpty,
                    itemList: GlobalCubit.get(context).homeResponse!.extraModel,
                  ),
                  ServiceView(
                    title: translate(AppStrings.service),
                    packageList:
                        GlobalCubit.get(context).homeResponse!.serviceModel!,
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

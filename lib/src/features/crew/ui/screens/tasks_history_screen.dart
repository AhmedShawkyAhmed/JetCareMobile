import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/core/routing/arguments/task_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:jetcare/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class TasksHistoryScreen extends StatefulWidget {
  const TasksHistoryScreen({super.key});

  @override
  State<TasksHistoryScreen> createState() => _TasksHistoryScreenState();
}

class _TasksHistoryScreenState extends State<TasksHistoryScreen> {
  CrewCubit cubit = CrewCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getMyTasksHistory(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: BodyView(
          hasBack: false,
          widget: Padding(
            padding: EdgeInsets.only(
              top: 4.h,
              left: 3.w,
              right: 3.w,
              bottom: 1.h,
            ),
            child: BlocBuilder<CrewCubit, CrewState>(
              builder: (context, state) {
                if (state is GetMyTasksHistoryLoading) {
                  return Container(
                    height: 80.h,
                    width: 90.w,
                    margin: EdgeInsets.only(top: 3.h),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return LoadingView(
                          width: 90.w,
                          height: 15.h,
                        );
                      },
                    ),
                  );
                } else {
                  return cubit.myTasksHistory!.isNotEmpty
                      ? Container(
                          height: 80.h,
                          width: 90.w,
                          margin: EdgeInsets.only(top: 3.h),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cubit.myTasksHistory!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  NavigationService.pushNamed(
                                    Routes.taskDetails,
                                    arguments: TaskArguments(
                                      order: cubit.myTasksHistory![index],
                                    ),
                                  );
                                },
                                child: CartItem(
                                  withDelete: false,
                                  onDelete: () {},
                                  name:
                                      "# ${cubit.myTasksHistory![index].id.toString()}",
                                  count: cubit.myTasksHistory![index].date
                                      .toString(),
                                  price: cubit.myTasksHistory![index].total
                                      .toString(),
                                  image: "1674441185.jpg",
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: DefaultText(
                            text: translate(AppStrings.noTasks),
                          ),
                        );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

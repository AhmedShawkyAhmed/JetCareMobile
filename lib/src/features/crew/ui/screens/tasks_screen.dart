import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/core/routing/arguments/task_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/services/navigation_service.dart';
import 'package:jetcare/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetcare/src/features/shared/views/body_view.dart';
import 'package:jetcare/src/features/shared/views/loading_view.dart';
import 'package:jetcare/src/features/shared/widgets/default_text.dart';
import 'package:jetcare/src/features/cart/ui/widgets/cart_item.dart';
import 'package:sizer/sizer.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late CrewCubit cubit = BlocProvider.of(context);

  @override
  void initState() {
    cubit.getMyTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (state is GetMyTasksLoading) {
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
              }
              return cubit.myTasks!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cubit.myTasks!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            NavigationService.pushNamed(
                              Routes.taskDetails,
                              arguments: TaskArguments(
                                order: cubit.myTasks![index],
                              ),
                            );
                          },
                          child: CartItem(
                            withDelete: false,
                            onDelete: () {},
                            name:
                                "# ${cubit.myTasks![index].id.toString()}",
                            count: cubit.myTasks![index].date.toString(),
                            price: cubit.myTasks![index].total.toString(),
                            image: "1674441185.jpg",
                          ),
                        );
                      },
                    )
                  : Center(
                      child: DefaultText(
                        text: translate(AppStrings.noTasks),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

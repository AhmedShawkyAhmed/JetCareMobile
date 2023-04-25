import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/constants/app_strings.dart';
import 'package:jetcare/src/presentation/styles/app_colors.dart';

class CrewLayoutScreen extends StatefulWidget {
  const CrewLayoutScreen({Key? key}) : super(key: key);

  @override
  State<CrewLayoutScreen> createState() => _CrewLayoutScreenState();
}

class _CrewLayoutScreenState extends State<CrewLayoutScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
      backgroundColor: AppColors.mainColor,
          key: scaffoldKey,
          body:  AppCubit.get(context).crewScreens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: AppColors.mainColor,
            selectedItemColor: AppColors.pc,
            unselectedItemColor: AppColors.shade,
            type: BottomNavigationBarType.fixed,
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeIndex(index);
            },
            items:  [
              BottomNavigationBarItem(
                icon:  const Icon(
                  Icons.sticky_note_2_outlined,
                ),
                label: translate(AppStrings.tasks),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.work_history_outlined,
                ),
                label:translate(AppStrings.history),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.more_horiz_outlined,
                ),
                label: translate(AppStrings.more),
              ),
            ],
          ),
        );
      },
    );
  }
}

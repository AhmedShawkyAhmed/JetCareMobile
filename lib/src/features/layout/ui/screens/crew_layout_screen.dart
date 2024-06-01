import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/resources/app_colors.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';

class CrewLayoutScreen extends StatefulWidget {
  final int? current;

  const CrewLayoutScreen({this.current, super.key});

  @override
  State<CrewLayoutScreen> createState() => _CrewLayoutScreenState();
}

class _CrewLayoutScreenState extends State<CrewLayoutScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late LayoutCubit cubit = BlocProvider.of(context);
  @override
  void initState() {
    if (widget.current != null) {
      cubit.currentIndex = widget.current!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          key: scaffoldKey,
          body: cubit.crewScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: AppColors.mainColor,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.shade,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.crewItem,
          ),
        );
      },
    );
  }
}

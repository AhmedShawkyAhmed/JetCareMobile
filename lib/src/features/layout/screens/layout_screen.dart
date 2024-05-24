import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late LayoutCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          key: scaffoldKey,
          body: cubit.clientScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: AppColors.mainColor,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.shade,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.clientItem,
          ),
        );
      },
    );
  }
}

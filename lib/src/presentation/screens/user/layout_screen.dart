import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/business_logic/app_cubit/app_cubit.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.mainColor,
          key: scaffoldKey,
          body: AppCubit().clientScreens[AppCubit().currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: AppColors.mainColor,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.shade,
            type: BottomNavigationBarType.fixed,
            currentIndex: AppCubit().currentIndex,
            onTap: (index) {
              AppCubit().changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: translate(AppStrings.home),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.sticky_note_2_outlined,
                ),
                label: translate(AppStrings.myOrders),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: translate(AppStrings.cart),
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

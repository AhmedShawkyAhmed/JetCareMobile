import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jetcare/src/core/constants/app_strings.dart';
import 'package:jetcare/src/features/crew/screens/tasks_history_screen.dart';
import 'package:jetcare/src/features/crew/screens/tasks_screen.dart';
import 'package:jetcare/src/presentation/screens/user/cart_screen.dart';
import 'package:jetcare/src/presentation/screens/user/history_screen.dart';
import 'package:jetcare/src/presentation/screens/user/home_screen.dart';
import 'package:jetcare/src/features/support/screens/more_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add;

  final List<Widget> clientScreens = [
    const HomeScreen(),
    const HistoryScreen(),
    const CartScreen(),
    const MoreScreen(),
  ];

  final List<BottomNavigationBarItem> clientItem = [
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
  ];
  final List<BottomNavigationBarItem> crewItem = [
    BottomNavigationBarItem(
      icon: const Icon(
        Icons.sticky_note_2_outlined,
      ),
      label: translate(AppStrings.tasks),
    ),
    BottomNavigationBarItem(
      icon: const Icon(
        Icons.work_history_outlined,
      ),
      label: translate(AppStrings.history),
    ),
    BottomNavigationBarItem(
      icon: const Icon(
        Icons.more_horiz_outlined,
      ),
      label: translate(AppStrings.more),
    ),
  ];

  final List<Widget> crewScreens = [
    const TasksScreen(),
    const TasksHistoryScreen(),
    const MoreScreen(),
  ];

  init() {
    currentIndex = 0;
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}

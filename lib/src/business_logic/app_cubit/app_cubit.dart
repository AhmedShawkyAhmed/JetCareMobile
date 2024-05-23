import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/presentation/screens/crew/crew_history_screen.dart';
import 'package:jetcare/src/presentation/screens/crew/crew_home_screen.dart';
import 'package:jetcare/src/presentation/screens/user/cart_screen.dart';
import 'package:jetcare/src/presentation/screens/user/history_screen.dart';
import 'package:jetcare/src/presentation/screens/user/home_screen.dart';
import 'package:jetcare/src/presentation/screens/user/more_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add;

  final List<Widget> clientScreens = [
    const HomeScreen(),
    const HistoryScreen(),
    const CartScreen(),
    const MoreScreen(),
  ];

  final List<Widget> crewScreens = [
    const CrewHomeScreen(),
    const CrewHistoryScreen(),
    const MoreScreen(),
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}

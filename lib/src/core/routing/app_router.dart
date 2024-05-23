import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/routing/app_animation.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetcare/src/features/splash/screens/splash_screen.dart';
import 'package:jetcare/src/presentation/screens/crew/crew_layout_screen.dart';
import 'package:jetcare/src/presentation/screens/shared/disable_account_screen.dart';
import 'package:jetcare/src/presentation/screens/shared/notification_screen.dart';
import 'package:jetcare/src/presentation/screens/user/add_address_screen.dart';
import 'package:jetcare/src/presentation/screens/user/added_success_screen.dart';
import 'package:jetcare/src/presentation/screens/user/address_screen.dart';
import 'package:jetcare/src/presentation/screens/user/appointment_screen.dart';
import 'package:jetcare/src/presentation/screens/user/cart_screen.dart';
import 'package:jetcare/src/presentation/screens/user/category_screen.dart';
import 'package:jetcare/src/presentation/screens/user/confirm_order_screen.dart';
import 'package:jetcare/src/presentation/screens/user/contact_screen.dart';
import 'package:jetcare/src/presentation/screens/user/corporate_screen.dart';
import 'package:jetcare/src/presentation/screens/user/home_screen.dart';
import 'package:jetcare/src/presentation/screens/user/info_screen.dart';
import 'package:jetcare/src/presentation/screens/user/layout_screen.dart';
import 'package:jetcare/src/presentation/screens/user/login_screen.dart';
import 'package:jetcare/src/presentation/screens/user/map_screen.dart';
import 'package:jetcare/src/presentation/screens/user/order_details_screen.dart';
import 'package:jetcare/src/presentation/screens/user/otp_screen.dart';
import 'package:jetcare/src/presentation/screens/user/package_screen.dart';
import 'package:jetcare/src/features/profile/screens/profile_screen.dart';
import 'package:jetcare/src/presentation/screens/user/reset_password.dart';
import 'package:jetcare/src/presentation/screens/user/service_screen.dart';
import 'package:jetcare/src/presentation/screens/user/success_screen.dart';
import 'package:jetcare/src/presentation/screens/user/verify_phone.dart';
import 'package:jetcare/src/presentation/screens/user/welcome_screen.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    Routes? navigatedRoute = Routes.values
        .where((route) => route.path == settings.name)
        .first;
    if (settings.name == '/') {
      navigatedRoute = Routes.splash;
    }
    switch (navigatedRoute) {
      case Routes.splash:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => SplashCubit()..init(),
            child: const SplashScreen(),
          ),
        );
      case Routes.welcome:
        return CustomPageRouteTransiton.fadeOut(
          page: const WelcomeScreen(),
        );
      case Routes.resetPassword:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ResetPassword(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.profile:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ProfileScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.otp:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: OTPScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.confirmOrder:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ConfirmOrderScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.login:
        return CustomPageRouteTransiton.fadeOut(
          page: const LoginScreen(),
        );
      case Routes.disable:
        return CustomPageRouteTransiton.fadeOut(
          page: const DisableAccountScreen(),
        );
      case Routes.verify:
        return CustomPageRouteTransiton.fadeOut(
          page: VerifyPhone(),
        );
      case Routes.layout:
        return CustomPageRouteTransiton.fadeOut(
          page: const LayoutScreen(),
        );
      case Routes.crewLayout:
        return CustomPageRouteTransiton.fadeOut(
          page: const CrewLayoutScreen(),
        );
      case Routes.corporate:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: CorporateScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.orderDetails:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: OrderDetailsScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.serviceDetails:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ServiceScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.categoryDetails:
        return CustomPageRouteTransiton.fadeOut(
          page: const CategoryScreen(),
        );
      case Routes.addedToCart:
        return CustomPageRouteTransiton.fadeOut(
          page: const AddedSuccessScreen(),
        );
      case Routes.home:
        return CustomPageRouteTransiton.fadeOut(
          page: const HomeScreen(),
        );
      case Routes.packageDetails:
        return CustomPageRouteTransiton.fadeOut(
          page: const PackageScreen(),
        );
      case Routes.contact:
        return CustomPageRouteTransiton.fadeOut(
          page: ContactScreen(),
        );
      case Routes.address:
        return CustomPageRouteTransiton.fadeOut(
          page: const AddressScreen(),
        );
      case Routes.addAddress:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: AddAddressScreen(
            appRouterArguments: appRouterArgument,
          ),
        );
      case Routes.map:
        return CustomPageRouteTransiton.fadeOut(
          page: const MapScreen(),
        );
      case Routes.notification:
        return CustomPageRouteTransiton.fadeOut(
          page: const NotificationScreen(),
        );
      case Routes.cart:
        return CustomPageRouteTransiton.fadeOut(
          page: const CartScreen(),
        );
      case Routes.success:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: SuccessScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.info:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: InfoScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case Routes.appointment:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: AppointmentScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      default:
        return null;
    }
  }
}

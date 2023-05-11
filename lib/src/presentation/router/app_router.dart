import 'package:flutter/material.dart';
import 'package:jetcare/src/constants/constants_methods.dart';
import 'package:jetcare/src/presentation/router/app_animation.dart';
import 'package:jetcare/src/presentation/router/app_router_argument.dart';
import 'package:jetcare/src/presentation/router/app_router_names.dart';
import 'package:jetcare/src/presentation/screens/shared/disable_account_screen.dart';
import 'package:jetcare/src/presentation/screens/shared/notification_screen.dart';
import 'package:jetcare/src/presentation/screens/user/add_address_screen.dart';
import 'package:jetcare/src/presentation/screens/user/address_screen.dart';
import 'package:jetcare/src/presentation/screens/user/appointment_screen.dart';
import 'package:jetcare/src/presentation/screens/user/cart_screen.dart';
import 'package:jetcare/src/presentation/screens/user/category_screen.dart';
import 'package:jetcare/src/presentation/screens/user/confirm_order_screen.dart';
import 'package:jetcare/src/presentation/screens/user/contact_screen.dart';
import 'package:jetcare/src/presentation/screens/user/corporate_screen.dart';
import 'package:jetcare/src/presentation/screens/crew/crew_layout_screen.dart';
import 'package:jetcare/src/presentation/screens/user/home_screen.dart';
import 'package:jetcare/src/presentation/screens/user/info_screen.dart';
import 'package:jetcare/src/presentation/screens/user/layout_screen.dart';
import 'package:jetcare/src/presentation/screens/user/login_screen.dart';
import 'package:jetcare/src/presentation/screens/user/map_screen.dart';
import 'package:jetcare/src/presentation/screens/user/order_details_screen.dart';
import 'package:jetcare/src/presentation/screens/user/otp_screen.dart';
import 'package:jetcare/src/presentation/screens/user/package_screen.dart';
import 'package:jetcare/src/presentation/screens/user/profile_screen.dart';
import 'package:jetcare/src/presentation/screens/user/reset_password.dart';
import 'package:jetcare/src/presentation/screens/user/service_screen.dart';
import 'package:jetcare/src/presentation/screens/user/splash_screen.dart';
import 'package:jetcare/src/presentation/screens/user/success_screen.dart';
import 'package:jetcare/src/presentation/screens/user/verify_phone.dart';
import 'package:jetcare/src/presentation/screens/user/welcome_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    printResponse(settings.name.toString());
    switch (settings.name) {
      case AppRouterNames.splash:
        return CustomPageRouteTransiton.fadeOut(
          page: const SplashScreen(),
        );
      case AppRouterNames.welcome:
        return CustomPageRouteTransiton.fadeOut(
          page: const WelcomeScreen(),
        );
      case AppRouterNames.resetPassword:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ResetPassword(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.profile:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ProfileScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.otp:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: OTPScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.confirmOrder:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ConfirmOrderScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.login:
        return CustomPageRouteTransiton.fadeOut(
          page: const LoginScreen(),
        );
      case AppRouterNames.disable:
        return CustomPageRouteTransiton.fadeOut(
          page: const DisableAccountScreen(),
        );
      case AppRouterNames.verify:
        return CustomPageRouteTransiton.fadeOut(
          page: VerifyPhone(),
        );
      case AppRouterNames.layout:
        return CustomPageRouteTransiton.fadeOut(
          page: const LayoutScreen(),
        );
      case AppRouterNames.crewLayout:
        return CustomPageRouteTransiton.fadeOut(
          page: const CrewLayoutScreen(),
        );
      case AppRouterNames.corporate:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: CorporateScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.orderDetails:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: OrderDetailsScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.serviceDetails:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: ServiceScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.categoryDetails:
        return CustomPageRouteTransiton.fadeOut(
          page: const CategoryScreen(),
        );
      case AppRouterNames.home:
        return CustomPageRouteTransiton.fadeOut(
          page: const HomeScreen(),
        );
      case AppRouterNames.packageDetails:
        return CustomPageRouteTransiton.fadeOut(
          page: const PackageScreen(),
        );
      case AppRouterNames.contact:
        return CustomPageRouteTransiton.fadeOut(
          page: ContactScreen(),
        );
      case AppRouterNames.address:
        return CustomPageRouteTransiton.fadeOut(
          page: const AddressScreen(),
        );
      case AppRouterNames.addAddress:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: AddAddressScreen(
            appRouterArguments: appRouterArgument,
          ),
        );
      case AppRouterNames.map:
        return CustomPageRouteTransiton.fadeOut(
          page: const MapScreen(),
        );
      case AppRouterNames.notification:
        return CustomPageRouteTransiton.fadeOut(
          page: const NotificationScreen(),
        );
      case AppRouterNames.cart:
        return CustomPageRouteTransiton.fadeOut(
          page: const CartScreen(),
        );
      case AppRouterNames.success:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: SuccessScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.info:
        final AppRouterArgument appRouterArgument =
            settings.arguments as AppRouterArgument;
        return CustomPageRouteTransiton.fadeOut(
          page: InfoScreen(
            appRouterArgument: appRouterArgument,
          ),
        );
      case AppRouterNames.appointment:
        return CustomPageRouteTransiton.fadeOut(
          page: const AppointmentScreen(),
        );
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:jetcare/src/core/routing/app_animation.dart';
import 'package:jetcare/src/core/routing/arguments/appointment_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/home_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/order_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/otp_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/password_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/task_arguments.dart';
import 'package:jetcare/src/core/routing/routes.dart';
import 'package:jetcare/src/core/utils/enums.dart';
import 'package:jetcare/src/core/utils/extensions.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/address/data/models/address_model.dart';
import 'package:jetcare/src/features/address/ui/screens/add_address_screen.dart';
import 'package:jetcare/src/features/address/ui/screens/address_screen.dart';
import 'package:jetcare/src/features/address/ui/screens/map_screen.dart';
import 'package:jetcare/src/features/appointment/ui/screens/appointment_screen.dart';
import 'package:jetcare/src/features/auth/ui/screens/login_screen.dart';
import 'package:jetcare/src/features/auth/ui/screens/otp_screen.dart';
import 'package:jetcare/src/features/auth/ui/screens/register_screen.dart';
import 'package:jetcare/src/features/auth/ui/screens/reset_password.dart';
import 'package:jetcare/src/features/auth/ui/screens/verify_email.dart';
import 'package:jetcare/src/features/cart/ui/screens/added_to_cart_screen.dart';
import 'package:jetcare/src/features/corporate/data/models/corporate_model.dart';
import 'package:jetcare/src/features/corporate/ui/screens/corporate_details_screen.dart';
import 'package:jetcare/src/features/crew/ui/screens/task_details_screen.dart';
import 'package:jetcare/src/features/home/data/models/package_details_model.dart';
import 'package:jetcare/src/features/home/data/models/package_model.dart';
import 'package:jetcare/src/features/home/ui/screens/category_screen.dart';
import 'package:jetcare/src/features/home/ui/screens/corporate_screen.dart';
import 'package:jetcare/src/features/home/ui/screens/home_screen.dart';
import 'package:jetcare/src/features/home/ui/screens/package_screen.dart';
import 'package:jetcare/src/features/home/ui/screens/service_screen.dart';
import 'package:jetcare/src/features/layout/ui/screens/crew_layout_screen.dart';
import 'package:jetcare/src/features/layout/ui/screens/layout_screen.dart';
import 'package:jetcare/src/features/notifications/ui/screens/notification_screen.dart';
import 'package:jetcare/src/features/orders/ui/screens/confirm_order_screen.dart';
import 'package:jetcare/src/features/profile/ui/screens/profile_screen.dart';
import 'package:jetcare/src/features/shared/screens/deleted_account_screen.dart';
import 'package:jetcare/src/features/shared/screens/disable_account_screen.dart';
import 'package:jetcare/src/features/shared/screens/success_screen.dart';
import 'package:jetcare/src/features/shared/screens/welcome_screen.dart';
import 'package:jetcare/src/features/splash/ui/screens/splash_screen.dart';
import 'package:jetcare/src/features/support/ui/screens/contact_screen.dart';
import 'package:jetcare/src/features/support/ui/screens/info_screen.dart';

import 'arguments/register_arguments.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    Routes? navigatedRoute =
        Routes.values.firstWhereOrNull((route) => route.path == settings.name);
    printSuccess("Route => $navigatedRoute");
    if (settings.name == '/') {
      navigatedRoute = Routes.splash;
    }
    switch (navigatedRoute) {
      case Routes.splash:
        return CustomPageRouteTransition.fadeOut(
          page: const SplashScreen(),
        );
      case Routes.welcome:
        return CustomPageRouteTransition.fadeOut(
          page: const WelcomeScreen(),
        );
      case Routes.login:
        return CustomPageRouteTransition.fadeOut(
          page: const LoginScreen(),
        );
      case Routes.register:
        final RegisterArguments arg = settings.arguments as RegisterArguments;
        return CustomPageRouteTransition.fadeOut(
          page: RegisterScreen(arguments: arg),
        );
      case Routes.disable:
        return CustomPageRouteTransition.fadeOut(
          page: const DisableAccountScreen(),
        );
      case Routes.deleted:
        return CustomPageRouteTransition.fadeOut(
          page: const DeletedAccountScreen(),
        );
      case Routes.resetPassword:
        final PasswordArguments arguments =
            settings.arguments as PasswordArguments;
        return CustomPageRouteTransition.fadeOut(
          page: ResetPassword(arguments: arguments),
        );
      case Routes.profile:
        return CustomPageRouteTransition.fadeOut(
          page: const ProfileScreen(),
        );
      case Routes.otp:
        final OtpArguments arguments = settings.arguments as OtpArguments;
        return CustomPageRouteTransition.fadeOut(
          page: OTPScreen(arguments: arguments),
        );
      case Routes.confirmOrder:
        final OrderArguments arguments = settings.arguments as OrderArguments;
        return CustomPageRouteTransition.fadeOut(
          page: ConfirmOrderScreen(
            arguments: arguments,
          ),
        );
      case Routes.taskDetails:
        final TaskArguments arguments = settings.arguments as TaskArguments;
        return CustomPageRouteTransition.fadeOut(
          page: TaskDetailsScreen(arguments: arguments),
        );
      case Routes.verify:
        return CustomPageRouteTransition.fadeOut(
          page: const VerifyEmail(),
        );
      case Routes.layout:
        final int? current = settings.arguments as int?;
        return CustomPageRouteTransition.fadeOut(
          page: LayoutScreen(current: current),
        );
      case Routes.crewLayout:
        final int? current = settings.arguments as int?;
        return CustomPageRouteTransition.fadeOut(
          page: CrewLayoutScreen(current: current),
        );
      case Routes.corporateItems:
        final HomeArguments arguments = settings.arguments as HomeArguments;
        return CustomPageRouteTransition.fadeOut(
          page: CorporateScreen(arguments: arguments),
        );
      // case Routes.orderDetails:
      //   final OrderArguments arguments =
      //   settings.arguments as OrderArguments;
      //   return CustomPageRouteTransiton.fadeOut(
      //     page: OrderDetailsScreen(arguments: arguments),
      //   );
      case Routes.serviceItems:
        final HomeArguments arguments = settings.arguments as HomeArguments;
        return CustomPageRouteTransition.fadeOut(
          page: ServiceScreen(arguments: arguments),
        );
      case Routes.categoryItems:
        final PackageModel category = settings.arguments as PackageModel;
        return CustomPageRouteTransition.fadeOut(
          page: CategoryScreen(category: category),
        );
      case Routes.addedToCart:
        return CustomPageRouteTransition.fadeOut(
          page: const AddedToCartScreen(),
        );
      case Routes.corporateDetails:
        final CorporateModel corporate = settings.arguments as CorporateModel;
        return CustomPageRouteTransition.fadeOut(
          page: CorporateDetailsScreen(corporate: corporate),
        );
      case Routes.home:
        return CustomPageRouteTransition.fadeOut(
          page: const HomeScreen(),
        );
      case Routes.packageItems:
        final PackageDetailsModel packageDetails =
            settings.arguments as PackageDetailsModel;
        return CustomPageRouteTransition.fadeOut(
          page: PackageScreen(packageDetails: packageDetails),
        );
      case Routes.contact:
        return CustomPageRouteTransition.fadeOut(
          page: const ContactScreen(),
        );
      case Routes.address:
        return CustomPageRouteTransition.fadeOut(
          page: const AddressScreen(),
        );
      case Routes.addAddress:
        final AddressModel? address = settings.arguments as AddressModel?;
        return CustomPageRouteTransition.fadeOut(
          page: AddAddressScreen(address: address),
        );
      case Routes.map:
        return CustomPageRouteTransition.fadeOut(
          page: const MapScreen(),
        );
      case Routes.notification:
        return CustomPageRouteTransition.fadeOut(
          page: const NotificationScreen(),
        );
      case Routes.success:
        final SuccessType type = settings.arguments as SuccessType;
        return CustomPageRouteTransition.fadeOut(
          page: SuccessScreen(type: type),
        );
      case Routes.info:
        final InfoType type = settings.arguments as InfoType;
        return CustomPageRouteTransition.fadeOut(
          page: InfoScreen(type: type),
        );
      case Routes.appointment:
        final AppointmentArguments arguments =
            settings.arguments as AppointmentArguments;
        return CustomPageRouteTransition.fadeOut(
          page: AppointmentScreen(arguments: arguments),
        );
      default:
        return null;
    }
  }
}

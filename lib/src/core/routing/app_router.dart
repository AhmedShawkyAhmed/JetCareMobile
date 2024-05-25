import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetcare/src/core/di/service_locator.dart';
import 'package:jetcare/src/core/routing/app_animation.dart';
import 'package:jetcare/src/core/routing/app_router_names.dart';
import 'package:jetcare/src/core/routing/arguments/app_router_argument.dart';
import 'package:jetcare/src/core/routing/arguments/otp_arguments.dart';
import 'package:jetcare/src/core/routing/arguments/password_arguments.dart';
import 'package:jetcare/src/core/utils/extensions.dart';
import 'package:jetcare/src/core/utils/shared_methods.dart';
import 'package:jetcare/src/features/auth/cubit/auth_cubit.dart';
import 'package:jetcare/src/features/auth/screens/login_screen.dart';
import 'package:jetcare/src/features/auth/screens/otp_screen.dart';
import 'package:jetcare/src/features/auth/screens/register_screen.dart';
import 'package:jetcare/src/features/auth/screens/reset_password.dart';
import 'package:jetcare/src/features/auth/screens/verify_email.dart';
import 'package:jetcare/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetcare/src/features/layout/screens/crew_layout_screen.dart';
import 'package:jetcare/src/features/layout/screens/layout_screen.dart';
import 'package:jetcare/src/features/profile/cubit/profile_cubit.dart';
import 'package:jetcare/src/features/profile/screens/profile_screen.dart';
import 'package:jetcare/src/features/shared/screens/deleted_account_screen.dart';
import 'package:jetcare/src/features/shared/screens/disable_account_screen.dart';
import 'package:jetcare/src/features/splash/cubit/splash_cubit.dart';
import 'package:jetcare/src/features/splash/screens/splash_screen.dart';
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
import 'package:jetcare/src/presentation/screens/user/map_screen.dart';
import 'package:jetcare/src/presentation/screens/user/order_details_screen.dart';
import 'package:jetcare/src/presentation/screens/user/package_screen.dart';
import 'package:jetcare/src/presentation/screens/user/service_screen.dart';
import 'package:jetcare/src/presentation/screens/user/success_screen.dart';
import 'package:jetcare/src/presentation/screens/user/welcome_screen.dart';

import 'arguments/register_arguments.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    Routes? navigatedRoute =
        Routes.values.firstWhereOrNull((route) => route.path == settings.name);
    printSuccess(navigatedRoute);
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
      case Routes.login:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => AuthCubit(instance()),
            child: const LoginScreen(),
          ),
        );
      case Routes.register:
        final RegisterArguments arg = settings.arguments as RegisterArguments;
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => AuthCubit(instance()),
            child: RegisterScreen(arguments: arg),
          ),
        );
      case Routes.disable:
        return CustomPageRouteTransiton.fadeOut(
          page: const DisableAccountScreen(),
        );
      case Routes.deleted:
        return CustomPageRouteTransiton.fadeOut(
          page: const DeletedAccountScreen(),
        );
      case Routes.resetPassword:
        final PasswordArguments arguments =
            settings.arguments as PasswordArguments;
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => AuthCubit(instance()),
            child: ResetPassword(arguments: arguments),
          ),
        );
      case Routes.profile:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => ProfileCubit(instance())..initProfile(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.otp:
        final OtpArguments arguments = settings.arguments as OtpArguments;
        return CustomPageRouteTransiton.fadeOut(
          page: OTPScreen(
            arguments: arguments,
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
      case Routes.verify:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => AuthCubit(instance()),
            child: const VerifyEmail(),
          ),
        );
      case Routes.layout:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => LayoutCubit()..init(),
            child: const LayoutScreen(),
          ),
        );
      case Routes.crewLayout:
        return CustomPageRouteTransiton.fadeOut(
          page: BlocProvider(
            create: (context) => LayoutCubit()..init(),
            child: const CrewLayoutScreen(),
          ),
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

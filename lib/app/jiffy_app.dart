import 'package:competition/core/generic_widgets/custom_text_form_field/bloc/cubit/text_form_field_cubit.dart';
import 'package:competition/core/utils/constants.dart';
import 'package:competition/features/authentication/bloc/cubit/auth_cubit.dart';
import 'package:competition/features/cart/bloc/cubit/cubit_cart.dart';
import 'package:competition/features/home/bloc/cubit/cubit_home.dart';
import 'package:competition/features/layout/generic_widgets/bottom_navigation_bar/bloc/cubit/bottom_navigation_cubit.dart';
import 'package:competition/features/map/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:competition/features/map/core/cubit/route/route_cubit.dart';
import 'package:competition/features/map/core/cubit/search_cubit/search_cubit.dart';
import 'package:competition/features/ship/bloc/cubit_ship.dart';
import 'package:competition/features/splash/screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/colors.dart';
import '../features/profile/bloc/cubit/profile_cubit.dart';

class JiffyApp extends StatelessWidget {
  const JiffyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) =>
                GetLoctionCubit()
                  ..getCurrentLocation()),
            BlocProvider(create: (_) => RouteCubit()),
            BlocProvider(create: (_) => SearchCubit()),
            BlocProvider(create: (_) => HomeCubit()),
            BlocProvider(create: (_) =>
            ProfileCubit()
              ..loadUserData()),
            BlocProvider(create: (_) => LoginCubit()),
            BlocProvider(create: (_) => LogoutCubit()),
            BlocProvider(create: (_) => RegisterCubit()),
            BlocProvider(create: (_) => ResetPasswordCubit()),
            BlocProvider(create: (_) => CartCubit()),
            BlocProvider(create: (_) => ShipScreenCubit()),
            BlocProvider(create: (_) => TextFieldCubit()),
            BlocProvider(create: (_) => BottomNavigationCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jiffy',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
                primaryColor: AppColors.primary,
                colorScheme:
                const ColorScheme.light(primary: AppColors.primary),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.primary,
                  selectionColor: AppColors.primary.withOpacity(0.3),
                  selectionHandleColor: AppColors.primary,
                ),
                useMaterial3: true,
                fontFamily: AppConstants.appFont,
                scaffoldBackgroundColor: AppColors.offWhite,
                appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.offWhite)),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}

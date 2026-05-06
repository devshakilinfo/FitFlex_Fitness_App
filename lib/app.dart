import 'package:fit_flex3/routes/app_routes.dart' show AppRoute;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class FitFlex extends StatelessWidget {
  const FitFlex({super.key});

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return FutureBuilder<String?>(
          future: getToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data != null) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: AppRoute.getBottomNavbar(),
                builder: EasyLoading.init(),
                getPages: AppRoute.routes,
                initialBinding: ControllerBinder(),
                themeMode: ThemeMode.light,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
              );
            } else {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: AppRoute.getWelcomeScreen(),
                builder: EasyLoading.init(),
                getPages: AppRoute.routes,
                initialBinding: ControllerBinder(),
                themeMode: ThemeMode.light,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
              );
            }
          },
        );
      },
    );
  }
}

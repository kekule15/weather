
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/utils/overlay_service.dart';
import 'package:weather/utils/router.dart';
import 'package:weather/utils/temporary_storage.dart';
import 'package:weather/widgets/loading_overlay_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageManager.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeDataMode = ref.watch(themeDataProvider);
    ref.listen(loadingState.select((value) => value), (
      previous,
      current,
    ) {
      if (current) {
        OverlayService.showOverlay(context);
      } else {
        OverlayService.hideOverlay(context);
      }
    });
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: (widget, child) => AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarBrightness: themeDataMode.isdarkTheme!
                      ? Brightness.dark
                      : Brightness.light,
                  statusBarIconBrightness: themeDataMode.isdarkTheme!
                      ? Brightness.light
                      : Brightness.dark,
                  statusBarColor: Colors.transparent),
              child: LoadingOverlayWidget(
                  child: MaterialApp.router(
                darkTheme: themeDataMode.isdarkTheme!
                    ? themeDataMode.darkTheme
                    : themeDataMode.lightTheme,
                themeMode: ThemeMode.system,
                theme: themeDataMode.isdarkTheme!
                    ? themeDataMode.darkTheme
                    : themeDataMode.lightTheme,

                debugShowCheckedModeBanner: false,
                title: 'Weather',
                routerConfig: goRouter,

                //SplashScreen(),
              )),
            ));
  }
}

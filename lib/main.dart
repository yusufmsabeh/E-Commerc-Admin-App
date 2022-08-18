import 'package:e_commerce_admin/Providers/FireStoreProvider.dart';
import 'package:e_commerce_admin/Routers/AppRouter.dart';
import 'package:e_commerce_admin/Screens/ControlPage.dart';
import 'package:e_commerce_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(89, 86, 233, .1),
      100: Color.fromRGBO(89, 86, 233, .2),
      200: Color.fromRGBO(89, 86, 233, .3),
      300: Color.fromRGBO(89, 86, 233, .4),
      400: Color.fromRGBO(89, 86, 233, .5),
      500: Color.fromRGBO(89, 86, 233, .6),
      600: Color.fromRGBO(89, 86, 233, .7),
      700: Color.fromRGBO(89, 86, 233, .8),
      800: Color.fromRGBO(89, 86, 233, .9),
      900: Color.fromRGBO(89, 86, 233, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF5956E9, color);
    return ChangeNotifierProvider(
      create: (context) => FireStoreProvider(),
      child: ScreenUtilInit(
          designSize: const Size(414, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: AppRouter.navKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: colorCustom,)),
              home: ControlPage(),
            );
          }),
    );
  }
}

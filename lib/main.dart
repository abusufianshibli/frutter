import 'package:flutter/material.dart';
import 'package:frutter/core/auth/provider/auth.dart';
import 'package:frutter/core/custom_order/provider/custom_order_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frutter/di/di_service.dart' as di;
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'common/utils/route/route.dart';
import 'common/utils/theme/custom_themes.dart';
void main()async {
  di.setup();
  await GetStorage.init();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => CustomOrderProvider()),

    ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.appThemeData[AppTheme.light],
      onGenerateRoute: onGenerateRoute,
      initialRoute: RouteName.login,
    ),
    );

  }
}


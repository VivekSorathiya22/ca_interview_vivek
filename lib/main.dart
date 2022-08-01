import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pairing_app/util/app_constants.dart';
import 'package:pairing_app/util/routes.dart';
import 'package:pairing_app/view/login_screen.dart';

import 'helper/router_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    RouterHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      initialRoute: Routes.getLoginRoute(),
      onGenerateRoute: RouterHelper.router.generator,
      home: const LoginScreen(),
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    ));
  }
}

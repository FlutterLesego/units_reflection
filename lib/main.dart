import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lifecycle.dart';
import 'routes/routes.dart';
import 'services/unit_service.dart';
import 'services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (context) => UnitService(),
        )
      ],
      child: LifeCycle(
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.deepOrange,
                onPrimary: Colors.white,
                secondary: Colors.orange,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.white,
                onBackground: Colors.grey.shade300,
                surface: Colors.grey.shade200,
                onSurface: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.loadingPage,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}

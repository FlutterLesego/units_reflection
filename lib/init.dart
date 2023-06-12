import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'misc/constants.dart';
import 'routes/routes.dart';
import 'services/unit_service.dart';
import 'services/user_service.dart';

class InitApp {
  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<UnitService>()
          .getUnits(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.allUnitsPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/routes.dart';
import '../views/widgets/dialogs.dart';
import 'unit_service.dart';
import 'user_service.dart';

final loginFormKey = GlobalKey<FormState>();
final registerFormKey = GlobalKey<FormState>();

//create a new user method
void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name,
    required String confirmPassword}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (registerFormKey.currentState?.validate() ?? false) {
    if (confirmPassword.toString().trim() != password.toString().trim()) {
      showSnackBar(context, 'passwords do not match');
    } else {
      BackendlessUser user = BackendlessUser()
        ..email = email.trim()
        ..password = password.trim()
        ..putProperties({
          'name': name.trim(),
          'confirmPassword': confirmPassword.trim(),
        });

      String result = await context.read<UserService>().createUser(user);
      if (result != 'OK') {
        showSnackBar(context, result);
      } else {
        showSnackBar(context, 'Account Created Successfully!');
        Navigator.pop(context);
        showSnackBar(context, 'Please verify your email');
      }
    }
  }
}

//log in user method
void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (loginFormKey.currentState?.validate() ?? false) {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      //get the users' units
      context.read<UnitService>().getUnits(email);
      Navigator.of(context).popAndPushNamed(RouteManager.allUnitsPage);
    }
  }
}

//reset user password
void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(
        context, 'Please enter email address and click on "Reset Password"');
  } else {
    String result = await context.read<UserService>().resetPassword(email);
    if (result == 'OK') {
      showSnackBar(context, "Reset instructions sent to $email");
    } else {
      showSnackBar(context, result);
    }
  }
}

//log user out of the app
void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();

  if (result == 'OK') {
    context.read<UserService>().setCurrentUserToNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}

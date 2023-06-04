import 'package:backendless_todo_starter/models/unit.dart';
import 'package:backendless_todo_starter/services/unit_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/widgets/dialogs.dart';
import 'user_service.dart';

final unitFormKey = GlobalKey<FormState>();

//refresh units in the UI
void refreshUnitsInUI(BuildContext context) async {
  String result = await context
      .read<UnitService>()
      .getUnits(context.read<UserService>().currentUser!.email);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Units refreshed');
  }
}

//save all units in the UI
void saveAllUnitsInUI(BuildContext context) async {
  String result = await context
      .read<UnitService>()
      .saveUnitEntry(context.read<UserService>().currentUser!.email, true);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Unit saved!');
  }
}

//create a new unit in the UI
void createNewUnitInUI(BuildContext context,
    {required TextEditingController descController,
    required TextEditingController refController}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (descController.text.isEmpty || refController.text.isEmpty) {
    showSnackBar(context, 'Please fill in all fields');
  } else {
    Unit unit = Unit(
      unitDesc: descController.text.trim(),
      reflecions: refController.text.trim(),
      created: DateTime.now(),
    );
    if (context.read<UnitService>().units.contains(unit)) {
      showSnackBar(context, 'Unit already available');
    } else {
      descController.text = '';
      refController.text = '';
      context.read<UnitService>().createUnit(unit);
      context
          .read<UnitService>()
          .saveUnitEntry(context.read<UserService>().currentUser!.email, true);
      Navigator.pop(context);
    }
  }
}

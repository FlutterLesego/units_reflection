import 'package:backendless_todo_starter/misc/constants.dart';
import 'package:backendless_todo_starter/models/unit.dart';
import 'package:backendless_todo_starter/services/unit_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitView extends StatelessWidget {
  const UnitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Selector<UnitService, Unit>(
          selector: (context, viewModel) => viewModel.selectedUnit!,
          builder: (context, selectedUnit, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    selectedUnit.unitDesc,
                    style: appTextStyle(20, Colors.black, FontWeight.bold),
                  ),
                  SizedBoxH10(),
                  Text(
                    selectedUnit.reflecions,
                    style: appTextStyle(
                        20, Colors.black.withOpacity(0.7), FontWeight.w300),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

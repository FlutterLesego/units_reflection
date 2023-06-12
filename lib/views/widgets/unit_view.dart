import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../misc/constants.dart';
import '../../models/unit.dart';
import '../../services/unit_service.dart';

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
                  Divider(
                    height: 2.0,
                    color: Colors.orange,
                  ),
                  SizedBoxH10(),
                  Text(
                    selectedUnit.reflecions,
                    style: appTextStyle(
                        20, Colors.black.withOpacity(0.7), FontWeight.w400),
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

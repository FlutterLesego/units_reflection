import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';
import '../../misc/constants.dart';
import '../../misc/validators.dart';
import '../../routes/routes.dart';
import '../../services/helper_unit.dart';
import '../../services/helper_user.dart';
import '../../services/unit_service.dart';
import '../../services/user_service.dart';
import '../widgets/app_progress_indicator.dart';
import '../widgets/unit_card.dart';

class AllUnitsPage extends StatefulWidget {
  const AllUnitsPage({Key? key}) : super(key: key);

  @override
  _AllUnitsPageState createState() => _AllUnitsPageState();
}

class _AllUnitsPageState extends State<AllUnitsPage> {
  late TextEditingController unitDescController;
  late TextEditingController unitRefController;

  @override
  void initState() {
    super.initState();
    unitDescController = TextEditingController();
    unitRefController = TextEditingController();
  }

  @override
  void dispose() {
    unitDescController.dispose();
    unitRefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UnitService>().getUnits;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<UnitService>()
              .getUnits(context.read<UserService>().currentUser!.email);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepOrange, Colors.deepOrangeAccent.shade100],
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              refreshUnitsInUI(context);
                            },
                          ),
                          Text(
                            'Unit Reflections',
                            style:
                                appTextStyle(20, Colors.white, FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              logoutUserInUI(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: provider.Selector<UserService, BackendlessUser?>(
                          selector: (context, value) => value.currentUser,
                          builder: (context, value, child) {
                            return Text(
                              'Welcome, ${value?.getProperty('name')}!',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    SizedBoxH20(),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45))),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Reflections',
                                  style: appTextStyle(
                                      32, Colors.deepOrange, FontWeight.w300),
                                ),
                                SizedBoxH10(),
                                Expanded(
                                    child: provider.Selector<UnitService, List>(
                                  selector: (context, viewModel) =>
                                      viewModel.units,
                                  builder: (context, units, child) {
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: units.length,
                                      itemBuilder: (context, index) {
                                        return UnitCard(
                                          unit: units[index],
                                          todoToggleAction:
                                              (valueStatus) async {
                                            context
                                                .read<UnitService>()
                                                .toggleUnitDone(index);
                                          },
                                          deleteAction: (context) async {
                                            context
                                                .read<UnitService>()
                                                .deleteUnit(units[index]);
                                            saveAllUnitsInUI(context);
                                          },
                                          onTap: () {
                                            context
                                                .read<UnitService>()
                                                .selectedUnit = units[index];
                                            Navigator.of(context).pushNamed(
                                                RouteManager.unitViewPage);
                                          },
                                        );
                                      },
                                    );
                                  },
                                )),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              provider.Selector<UserService, Tuple2>(
                selector: (context, value) =>
                    Tuple2(value.showUserProgress, value.userProgressText),
                builder: (context, value, child) {
                  return value.item1
                      ? AppProgressIndicator(
                          text: value.item2, color: Colors.deepOrange)
                      : Container();
                },
              ),
              provider.Selector<UnitService, Tuple2>(
                selector: (context, value) =>
                    Tuple2(value.busyRetrieving, value.busySaving),
                builder: (context, value, child) {
                  return value.item1
                      ? AppProgressIndicator(color: Colors.deepOrange, text: '')
                      : value.item2
                          ? AppProgressIndicator(
                              color: Colors.deepOrange, text: '')
                          : Container();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  key: unitFormKey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text('Create a new unit'),
                  content: Wrap(
                    children: [
                      TextFormField(
                        validator: validateUnitDescription,
                        controller: unitDescController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelStyle: appTextStyle(
                              16, Colors.deepOrange, FontWeight.normal),
                          labelText: 'Unit description',
                        ),
                      ),
                      TextFormField(
                        validator: validateUnitReflection,
                        controller: unitRefController,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelStyle: appTextStyle(
                              16, Colors.deepOrange, FontWeight.w400),
                          labelText: 'Unit reflections',
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Save'),
                      onPressed: () async {
                        createNewUnitInUI(context,
                            descController: unitDescController,
                            refController: unitRefController);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'Add unit',
            style: appTextStyle(16, Colors.white, FontWeight.w400),
          )),
    );
  }
}

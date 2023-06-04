import 'dart:convert';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:backendless_todo_starter/models/unit.dart';
import 'package:backendless_todo_starter/models/unit_entry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../lifecycle.dart';
import 'unitprovider.dart';

class UnitService with ChangeNotifier {
  UnitService() {
    String username = '';
    getUnits(username);
  }
  UnitEntry? _unitEntry;

  List<Unit> _units = [];
  List<Unit> get units => _units;

  Unit? _selectedUnit;
  Unit? get selectedUnit => _selectedUnit;
  set selectedUnit(Unit? unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool _busyDeleting = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;
  bool get busyDeleting => _busyDeleting;

//provider for units from json data online
  Map<String, dynamic> unitsMap = {};

  Future<void> get fetchUnits async {
    final response = await get(Uri.parse(
        'https://dl.dropboxusercontent.com/s/q6chvs5eqktd1nb/unitReflections.json?dl=0'));

    if (response.statusCode == 200) {
      try {
        unitsMap = jsonDecode(response.body);
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception('Error: Please check internet connection.');
    }
  }

  //get the units from the backend
  Future<String> getUnits(String username) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    _busyRetrieving = true;
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('UnitEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    //check if there is an error and show it
    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    //convert map and save it into the service entry
    if (map != null) {
      if (map.length > 0) {
        _unitEntry = UnitEntry.fromJson(map.first);
        _units = await UnitProvider.fetchUnits()
            .then((value) => convertMapToUnitList(_unitEntry!.units));
        notifyListeners();
      } else {
        try {
          _units = await UnitProvider.fetchUnits();
          notifyListeners();
        } catch (e) {
          result = e.toString();
          notifyListeners();
        }
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  //save a unit entry to the database
  Future<String> saveUnitEntry(String username, bool inUI) async {
    String result = 'OK';
    if (_unitEntry == null) {
      _unitEntry =
          UnitEntry(units: convertUnitListToMap(_units), username: username);
    } else {
      _unitEntry!.units = convertUnitListToMap(_units);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }
    await Backendless.data
        .of('UnitEntry')
        .save(_unitEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }

    return result;
  }

//togele unit if done or not
  void toggleUnitDone(int index) {
    _units[index].done = !_units[index].done;
    notifyListeners();
    setUIStateFlag(UIState.CHANGED);
  }

//delete a unit
  void deleteUnit(Unit unit) {
    _units.remove(unit);
    notifyListeners();
    setUIStateFlag(UIState.CHANGED);
  }

//create a unit
  void createUnit(Unit unit) {
    _units.insert(0, unit);
    notifyListeners();
    setUIStateFlag(UIState.CHANGED);
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../models/unit.dart';

class UnitProvider {
  //provider for units from json data online

  static Future<List<Unit>> fetchUnits() async {
    List<Unit> units = [];
    Map<String, dynamic> unitsMap = {};
    final response = await get(Uri.parse(
        'https://dl.dropboxusercontent.com/s/q6chvs5eqktd1nb/unitReflections.json?dl=0'));

    if (response.statusCode == 200) {
      try {
        unitsMap = jsonDecode(response.body);
      } catch (e) {
        unitsMap;
        throw Exception(e.toString());
      }
    } else {
      unitsMap;
      throw Exception('Error: Please check internet connection.');
    }
    return units;
  }
}

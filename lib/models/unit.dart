Map<dynamic, dynamic> convertUnitListToMap(List<Unit> units) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < units.length; i++) {
    map.addAll({'$i': units[i].toJson()});
  }
  return map;
}

List<Unit> convertMapToUnitList(Map<dynamic, dynamic> map) {
  List<Unit> units = [];
  for (var i = 0; i < map.length; i++) {
    units.add(Unit.fromJson(map['$i']));
  }
  return units;
}

class Unit {
  final String unitDesc;
  bool done;
  final String reflecions;
  final DateTime created;

  Unit({
    required this.unitDesc,
    required this.reflecions,
    this.done = false,
    required this.created,
  });

  Map<String, Object?> toJson() => {
        'description': unitDesc,
        'reflections': reflecions,
        'done': done ? 1 : 0,
        'created': created.millisecondsSinceEpoch,
      };

  static Unit fromJson(Map<dynamic, dynamic>? json) => Unit(
        unitDesc: json!['description'] as String,
        reflecions: json['reflections'] as String,
        done: json['done'] == 1 ? true : false,
        created: DateTime.fromMillisecondsSinceEpoch(
            (json['created'] as double).toInt()),
      );

  @override
  bool operator ==(covariant Unit unit) {
    return (this
            .unitDesc
            .toUpperCase()
            .compareTo(unit.unitDesc.toUpperCase()) ==
        0);
  }

  @override
  int get hashCode {
    return unitDesc.hashCode;
  }
}

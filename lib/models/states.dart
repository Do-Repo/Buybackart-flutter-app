import 'dart:convert';

class States {
  int id;
  String name;
  List<Cities> cities;
  States({
    required this.id,
    required this.name,
    required this.cities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cities': cities.map((x) => x.toMap()).toList(),
    };
  }

  factory States.fromMap(Map<String, dynamic> map) {
    return States(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      cities: List<Cities>.from(map['cities']?.map((x) => Cities.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory States.fromJson(String source) => States.fromMap(json.decode(source));
}

class Cities {
  int id;
  String state;
  String name;
  Cities({
    required this.id,
    required this.state,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state': state,
      'name': name,
    };
  }

  factory Cities.fromMap(Map<String, dynamic> map) {
    return Cities(
      id: map['id']?.toInt() ?? 0,
      state: map['state'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cities.fromJson(String source) => Cities.fromMap(json.decode(source));
}

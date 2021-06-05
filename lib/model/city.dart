class CityList {
  List names;
  CityList({this.names});

  factory CityList.fromJSON(Map<String, dynamic> json) {
    Iterable results = json['results'];
    List citiesName = results.map((e) => City.fromJSON(e)).toList();
    return CityList(names: citiesName);
  }
}

class City {
  String name;

  City({this.name});

  factory City.fromJSON(Map<String, dynamic> json) {
    return City(
      name: json['name'],
    );
  }
}

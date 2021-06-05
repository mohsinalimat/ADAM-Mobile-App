class CountryList {
  List<Country> names;
  CountryList({this.names});

  factory CountryList.fromJSON(List json) {
    Iterable allNames = json.map((e) => Country.fromJSON(e)).toList();
    return CountryList(names: allNames);
  }
}

class Country {
  String name;

  Country({this.name});

  factory Country.fromJSON(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
    );
  }
}

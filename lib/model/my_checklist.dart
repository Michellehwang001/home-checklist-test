class MyChecklist {
  String? id;
  String? email;
  String? alias;
  String? housing;
  String? mainChecked;
  String? subChecked;
  int? time;
  // Set<int?> checked;

  MyChecklist(this.email, this.alias, this.housing, this.mainChecked, this.subChecked, this.time);

  MyChecklist.fromJson(dynamic json) {
    id = json["id"];
    email = json["email"];
    alias = json["alias"];
    housing = json["housing"];
    mainChecked = json["mainChecked"];
    subChecked = json["subChecked"];
    time = json["time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["email"] = email;
    map["alias"] = alias;
    map["housing"] = housing;
    map["mainChecked"] = mainChecked;
    map["subChecked"] = subChecked;
    map["time"] = time;
    return map;
  }
}
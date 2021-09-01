class ChecklistModel {
  int? index;
  String? title;
  String? housing;
  String? article;

  ChecklistModel(this.index, this.title, this.housing, this.article);

  ChecklistModel.fromJson(dynamic json) {
    index = json["index"];
    title = json["title"];
    housing = json["housing"];
    article = json["article"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["index"] = index;
    map["title"] = title;
    map["housing"] = housing;
    map["article"] = article;
    return map;
  }
}
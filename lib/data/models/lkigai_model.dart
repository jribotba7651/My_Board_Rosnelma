// ignore_for_file: prefer_collection_literals

class LkigaiModel {
  String? title;
  String? description;
  List<String>? image;
  String? sId;

  LkigaiModel({this.title, this.description, this.image, this.sId});

  LkigaiModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['image'] =image;
    return data;
  }
}

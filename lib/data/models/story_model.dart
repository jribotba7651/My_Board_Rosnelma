class StoryModel {
  String? sId;
  String? title;
  String? description;
  List<String>? image;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  StoryModel({sId, title, description, image, createdBy, createdAt, updatedAt});

  StoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'].cast<String>();
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}

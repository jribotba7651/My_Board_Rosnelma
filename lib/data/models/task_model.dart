class TaskModel {
  String? sId;
  String? title;
  String? description;
  List<String>? image;
  String? startedOn;
  String? status;
  String? deadline;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  TaskModel(
      {sId,
      title,
      description,
      image,
      startedOn,
      status,
      deadline,
      createdBy,
      createdAt,
      updatedAt});

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'].cast<String>();
    startedOn = json['startedOn'];
    status = json['status'];
    deadline = json['deadline'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['_id'] =  sId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['startedOn'] = startedOn;
    data['status'] = status;
    data['deadline'] = deadline;
    // data['createdBy'] =  createdBy;
    //data['createdAt'] =  createdAt;
    // data['updatedAt'] =  updatedAt;
    return data;
  }
}

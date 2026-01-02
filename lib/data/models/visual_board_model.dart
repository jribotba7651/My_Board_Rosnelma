class Detail {
  String? title;
  String? description;
  List<String>? image;
  String? sId;

  Detail({this.title, this.description, this.image, this.sId});

  Detail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image']?.cast<String>() ?? [];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['_id'] = this.sId;
    return data;
  }
}

class VisualBoardModel {
  String? sId;
  String? createdBy;
  int? iV;
  List<Detail>? capability;
  String? createdAt;
  List<Detail>? longTermGoal;
  List<Detail>? mission;
  List<Detail>? passion;
  List<Detail>? personalGoal;
  List<Detail>? profession;
  List<Detail>? roleModel;
  List<Detail>? shortTermGoal;
  String? updatedAt;
  List<Detail>? visualRepresentation;
  List<Detail>? vocation;

  VisualBoardModel({
    this.sId,
    this.createdBy,
    this.iV,
    this.capability,
    this.createdAt,
    this.longTermGoal,
    this.mission,
    this.passion,
    this.personalGoal,
    this.profession,
    this.roleModel,
    this.shortTermGoal,
    this.updatedAt,
    this.visualRepresentation,
    this.vocation,
  });

  VisualBoardModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdBy = json['createdBy'];
    iV = json['__v'];
    capability = (json['capability'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    createdAt = json['createdAt'];
    longTermGoal = (json['longTermGoal'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    mission = (json['mission'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    passion = (json['passion'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    personalGoal = (json['personalGoal'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    profession = (json['profession'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    roleModel = (json['roleModel'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    shortTermGoal = (json['shortTermGoal'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    updatedAt = json['updatedAt'];
    visualRepresentation = (json['visualRepresentation'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
    vocation = (json['vocation'] as List?)?.map((v) => Detail.fromJson(v)).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    data['capability'] = this.capability?.map((v) => v.toJson()).toList();
    data['createdAt'] = this.createdAt;
    data['longTermGoal'] = this.longTermGoal?.map((v) => v.toJson()).toList();
    data['mission'] = this.mission?.map((v) => v.toJson()).toList();
    data['passion'] = this.passion?.map((v) => v.toJson()).toList();
    data['personalGoal'] = this.personalGoal?.map((v) => v.toJson()).toList();
    data['profession'] = this.profession?.map((v) => v.toJson()).toList();
    data['roleModel'] = this.roleModel?.map((v) => v.toJson()).toList();
    data['shortTermGoal'] = this.shortTermGoal?.map((v) => v.toJson()).toList();
    data['updatedAt'] = this.updatedAt;
    data['visualRepresentation'] = this.visualRepresentation?.map((v) => v.toJson()).toList();
    data['vocation'] = this.vocation?.map((v) => v.toJson()).toList();
    return data;
  }
}

// ignore_for_file: prefer_collection_literals

class MySessionResultModel {
  String? sessionId;
  String? title;
  List<AttemptedBy>? attemptedBy;

  MySessionResultModel({this.sessionId, this.title, this.attemptedBy});

  MySessionResultModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
    title = json['title'];
    if (json['attemptedBy'] != null) {
      attemptedBy = <AttemptedBy>[];
      json['attemptedBy'].forEach((v) {
        attemptedBy!.add(  AttemptedBy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['sessionId'] = sessionId;
    data['title'] =  title;
    if ( attemptedBy != null) {
      data['attemptedBy'] =  attemptedBy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttemptedBy {
  String? sId;
  String? name;
  String? role;

  AttemptedBy({this.sId, this.name, this.role});

  AttemptedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] =name;
    data['role'] =role;
    return data;
  }
}

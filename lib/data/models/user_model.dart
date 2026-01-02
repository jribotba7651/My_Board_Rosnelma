class UserModel {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? code;
  bool? isSubscriber;
  int? referralCode;

  UserModel({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.code,
    this.isSubscriber,
    this.referralCode,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSubscriber = json['isSubscriber'] ?? false;
    referralCode = json['referralCode'] ?? 123456;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['code'] = code;
    data['isSubscriber'] = isSubscriber ?? false;
    data['referralCode']=referralCode ?? 123456;
    return data;
  }
}

class ProfileModel {
  int? noOfPassions;
  int? noOfProfessions;
  int? noOfMissions;
  int? noOfVocation;
  int? noOfTasks;
  int? noOfStory;
  int? noOfShortTermGoal;
  int? noOfLongTermGoal;
  int? noOfCapabilities;
  int? noOfPersonalGoal;
  int? noOfRoleModels;
  int? noOfVisualRepresentation;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  bool? isSubscriber;
  String? image;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? referralCode;

  ProfileModel({
    this.noOfPassions,
    this.noOfProfessions,
    this.noOfMissions,
    this.noOfVocation,
    this.noOfTasks,
    this.noOfStory,
    this.noOfShortTermGoal,
    this.noOfLongTermGoal,
    this.noOfCapabilities,
    this.noOfPersonalGoal,
    this.noOfRoleModels,
    this.noOfVisualRepresentation,
    this.sId,
    this.firstName,
    this.lastName,
    this.email,
    this.isSubscriber,
    this.image,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : noOfPassions = json['noOfPassions'],
        noOfProfessions = json['noOfProfessions'],
        noOfMissions = json['noOfMissions'],
        noOfVocation = json['noOfVocation'],
        noOfTasks = json['noOfTasks'],
        noOfStory = json['noOfStory'],
        noOfShortTermGoal = json['noOfShortTermGoal'],
        noOfLongTermGoal = json['noOfLongTermGoal'],
        noOfCapabilities = json['noOfCapabilities'],
        noOfPersonalGoal = json['noOfPersonalGoal'],
        noOfRoleModels = json['noOfRoleModels'],
        noOfVisualRepresentation = json['noOfVisualRepresentation'],
        sId = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        isSubscriber = json['isSubscriber'],
        image = json['image'],
        role = json['role'],
        referralCode = json['referralCode'] ?? 123456,
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'noOfPassions': noOfPassions,
      'noOfProfessions': noOfProfessions,
      'noOfMissions': noOfMissions,
      'noOfVocation': noOfVocation,
      'noOfTasks': noOfTasks,
      'noOfStory': noOfStory,
      'noOfShortTermGoal': noOfShortTermGoal,
      'noOfLongTermGoal': noOfLongTermGoal,
      'noOfCapabilities': noOfCapabilities,
      'noOfPersonalGoal': noOfPersonalGoal,
      'noOfRoleModels': noOfRoleModels,
      'noOfVisualRepresentation': noOfVisualRepresentation,
      '_id': sId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'isSubscriber': isSubscriber,
      'image': image,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

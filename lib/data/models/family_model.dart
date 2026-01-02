class FamilyTreeModel {
  String? sId;
  String? createdBy;
  String? ownerName;
  Husband? husband;
  List<Brother>? brother;
  List<Sister>? sister;
  List<Son>? sons;
  List<Daughter>? daughters;
  List<Sibling>? siblings;
  int? iV;
  Husband? grandFather;
  Husband? grandMother;
  Husband? wife;
  Husband? mother;
  Husband? father;

  FamilyTreeModel({
    this.sId,
    this.createdBy,
    this.ownerName,
    this.husband,
    this.brother,
    this.sister,
    this.sons,
    this.daughters,
    this.siblings,
    this.iV,
    this.grandFather,
    this.grandMother,
    this.wife,
    this.mother,
    this.father,
  });

  factory FamilyTreeModel.fromJson(Map<String, dynamic> json) {
    return FamilyTreeModel(
      sId: json['_id'],
      createdBy: json['createdBy'],
      ownerName: json['ownerName'],
      husband: json['husband'] != null ? Husband.fromJson(json['husband']) : null,
      brother: json['brother'] != null
          ? (json['brother'] as List).map((e) => Brother.fromJson(e)).toList()
          : null,
      sister: json['sister'] != null
          ? (json['sister'] as List).map((e) => Sister.fromJson(e)).toList()
          : null,
      sons: json['sons'] != null
          ? (json['sons'] as List).map((e) => Son.fromJson(e)).toList()
          : null,
      daughters: json['daughters'] != null
          ? (json['daughters'] as List).map((e) => Daughter.fromJson(e)).toList()
          : null,
      siblings: json['siblings'] != null
          ? (json['siblings'] as List).map((e) => Sibling.fromJson(e)).toList()
          : null,
      iV: json['__v'],
      grandFather: json['grandFather'] != null
          ? Husband.fromJson(json['grandFather'])
          : null,
      grandMother: json['grandMother'] != null
          ? Husband.fromJson(json['grandMother'])
          : null,
      wife: json['wife'] != null ? Husband.fromJson(json['wife']) : null,
      mother: json['mother'] != null ? Husband.fromJson(json['mother']) : null,
      father: json['father'] != null ? Husband.fromJson(json['father']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'createdBy': createdBy,
      'ownerName': ownerName,
      'husband': husband?.toJson(),
      'brother': brother?.map((e) => e.toJson()).toList(),
      'sister': sister?.map((e) => e.toJson()).toList(),
      'sons': sons?.map((e) => e.toJson()).toList(),
      'daughters': daughters?.map((e) => e.toJson()).toList(),
      'siblings': siblings?.map((e) => e.toJson()).toList(),
      '__v': iV,
      'grandFather': grandFather?.toJson(),
      'grandMother': grandMother?.toJson(),
      'wife': wife?.toJson(),
      'mother': mother?.toJson(),
      'father': father?.toJson(),
    };
  }
}

class Husband {
  String? firstName;
  String? lastName;
  String? relation;
  String? dob;
  String? image;
  bool? isAlive;
  String? sId;

  Husband({
    this.firstName,
    this.lastName,
    this.relation,
    this.dob,
    this.image,
    this.isAlive,
    this.sId,
  });

  factory Husband.fromJson(Map<String, dynamic> json) {
    return Husband(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'relation': relation,
      'dob': dob,
      'image': image,
      'isAlive': isAlive,
      '_id': sId,
    };
  }
}

class Brother extends Husband {
  Brother({
    String? firstName,
    String? lastName,
    String? relation,
    String? dob,
    String? image,
    bool? isAlive,
    String? sId,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          relation: relation,
          dob: dob,
          image: image,
          isAlive: isAlive,
          sId: sId,
        );

  factory Brother.fromJson(Map<String, dynamic> json) {
    return Brother(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

class Sister extends Husband {
  Sister({
    String? firstName,
    String? lastName,
    String? relation,
    String? dob,
    String? image,
    bool? isAlive,
    String? sId,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          relation: relation,
          dob: dob,
          image: image,
          isAlive: isAlive,
          sId: sId,
        );

  factory Sister.fromJson(Map<String, dynamic> json) {
    return Sister(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

class Son extends Husband {
  Son({
    String? firstName,
    String? lastName,
    String? relation,
    String? dob,
    String? image,
    bool? isAlive,
    String? sId,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          relation: relation,
          dob: dob,
          image: image,
          isAlive: isAlive,
          sId: sId,
        );

  factory Son.fromJson(Map<String, dynamic> json) {
    return Son(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

class Daughter extends Husband {
  Daughter({
    String? firstName,
    String? lastName,
    String? relation,
    String? dob,
    String? image,
    bool? isAlive,
    String? sId,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          relation: relation,
          dob: dob,
          image: image,
          isAlive: isAlive,
          sId: sId,
        );

  factory Daughter.fromJson(Map<String, dynamic> json) {
    return Daughter(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

class Sibling extends Husband {
  Sibling({
    String? firstName,
    String? lastName,
    String? relation,
    String? dob,
    String? image,
    bool? isAlive,
    String? sId,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          relation: relation,
          dob: dob,
          image: image,
          isAlive: isAlive,
          sId: sId,
        );

  factory Sibling.fromJson(Map<String, dynamic> json) {
    return Sibling(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relation: json['relation'],
      dob: json['dob'],
      image: json['image'],
      isAlive: json['isAlive'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

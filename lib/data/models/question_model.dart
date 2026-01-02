class QuestionModel {
  String? questionType;
  String? question;
  String? correctOption;
  String? userAttempt;
  List<String>? options;

  QuestionModel(
      {this.questionType,
      this.question,
      this.correctOption,
      this.options,
      this.userAttempt});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    questionType = json['questionType'];
    question = json['question'];
    correctOption = json['correctOption'];
    userAttempt = json['userAttempt'];
    if (json['options'] != null) {
      options = List<String>.from(json['options']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['questionType'] = questionType;
    data['question'] = question;
    data['correctOption'] = correctOption;
    if (options != null) {
      data['options'] = options;
    }
    return data;
  }
}

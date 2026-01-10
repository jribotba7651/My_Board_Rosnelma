class QuantumCardModel {
  String id;
  String title;
  String description;
  String category;
  String period;
  int estimatedTime;
  String difficulty;
  List<String> tags;
  List<String> instructions;
  List<String> benefits;
  bool isCompleted;
  DateTime createdAt;

  QuantumCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.period,
    required this.estimatedTime,
    required this.difficulty,
    required this.tags,
    required this.instructions,
    required this.benefits,
    this.isCompleted = false,
    required this.createdAt,
  });

  // Copy with method for immutable updates
  QuantumCardModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? period,
    int? estimatedTime,
    String? difficulty,
    List<String>? tags,
    List<String>? instructions,
    List<String>? benefits,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return QuantumCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      period: period ?? this.period,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      instructions: instructions ?? this.instructions,
      benefits: benefits ?? this.benefits,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // From JSON constructor
  QuantumCardModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? '',
        category = json['category'] ?? '',
        period = json['period'] ?? '',
        estimatedTime = json['estimatedTime'] ?? 0,
        difficulty = json['difficulty'] ?? '',
        tags = json['tags'] != null ? List<String>.from(json['tags']) : [],
        instructions = json['instructions'] != null
            ? List<String>.from(json['instructions']) : [],
        benefits = json['benefits'] != null
            ? List<String>.from(json['benefits']) : [],
        isCompleted = json['isCompleted'] ?? false,
        createdAt = json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now();

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['period'] = period;
    data['estimatedTime'] = estimatedTime;
    data['difficulty'] = difficulty;
    data['tags'] = tags;
    data['instructions'] = instructions;
    data['benefits'] = benefits;
    data['isCompleted'] = isCompleted;
    data['createdAt'] = createdAt.toIso8601String();
    return data;
  }

  // Helper method to get category color
  String getCategoryColor() {
    switch (category.toLowerCase()) {
      case 'mindfulness':
        return '#667eea';
      case 'creativity':
        return '#f093fb';
      case 'focus':
        return '#4facfe';
      case 'wellness':
        return '#43e97b';
      case 'reflection':
        return '#fa709a';
      default:
        return '#667eea';
    }
  }

  // Helper method to get difficulty level
  int getDifficultyLevel() {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 1;
      case 'medium':
        return 2;
      case 'hard':
        return 3;
      default:
        return 1;
    }
  }

  // Helper method to get formatted time
  String getFormattedTime() {
    if (estimatedTime < 60) {
      return '$estimatedTime min';
    } else {
      final hours = (estimatedTime / 60).floor();
      final minutes = estimatedTime % 60;
      if (minutes == 0) {
        return '$hours hr';
      } else {
        return '$hours hr $minutes min';
      }
    }
  }

  @override
  String toString() {
    return 'QuantumCardModel(id: $id, title: $title, category: $category, period: $period, estimatedTime: $estimatedTime, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuantumCardModel &&
        other.id == id &&
        other.title == title &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ category.hashCode;
  }
}
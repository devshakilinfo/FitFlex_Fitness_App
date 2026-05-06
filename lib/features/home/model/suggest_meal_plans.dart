class SuggestMealData {
  HeightRange? heightRange;
  HeightRange? weightRange;
  String? sId;
  String? title;
  String? description;
  String? fitnessLevel;
  dynamic image; // Since image can be null or dynamic
  List<String>? breakfast;
  List<String>? lunch;
  List<String>? dinner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SuggestMealData({
    this.heightRange,
    this.weightRange,
    this.sId,
    this.title,
    this.description,
    this.fitnessLevel,
    this.image,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SuggestMealData.fromJson(Map<String, dynamic> json) {
    heightRange =
        json['heightRange'] != null
            ? HeightRange.fromJson(json['heightRange'])
            : null;
    weightRange =
        json['weightRange'] != null
            ? HeightRange.fromJson(json['weightRange'])
            : null;
    sId = json['_id'] as String?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    fitnessLevel = json['fitnessLevel'] as String?;
    image = json['image']; // Allowing any type
    breakfast = (json['breakfast'] as List?)?.map((e) => e.toString()).toList();
    lunch = (json['lunch'] as List?)?.map((e) => e.toString()).toList();
    dinner = (json['dinner'] as List?)?.map((e) => e.toString()).toList();
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    iV = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (heightRange != null) data['heightRange'] = heightRange!.toJson();
    if (weightRange != null) data['weightRange'] = weightRange!.toJson();
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['fitnessLevel'] = fitnessLevel;
    data['image'] = image;
    data['breakfast'] = breakfast;
    data['lunch'] = lunch;
    data['dinner'] = dinner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class HeightRange {
  int? min;
  int? max;

  HeightRange({this.min, this.max});

  HeightRange.fromJson(Map<String, dynamic> json) {
    min = json['min'] as int?;
    max = json['max'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

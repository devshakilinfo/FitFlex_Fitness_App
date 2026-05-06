class AllMealModels {
  HeightRange? heightRange;
  HeightRange? weightRange;
  String? sId;
  String? title;
  String? description;
  String? fitnessLevel;
  String? image;
  List<String>? breakfast;
  List<String>? lunch;
  List<String>? dinner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AllMealModels({
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

  AllMealModels.fromJson(Map<String, dynamic> json) {
    heightRange =
        json['heightRange'] != null
            ? HeightRange.fromJson(json['heightRange'])
            : null;
    weightRange =
        json['weightRange'] != null
            ? HeightRange.fromJson(json['weightRange'])
            : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    fitnessLevel = json['fitnessLevel'];
    image = json['image']?.toString();
    breakfast = json['breakfast'].cast<String>();
    lunch = json['lunch'].cast<String>();
    dinner = json['dinner'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class HeightRange {
  int? min;
  int? max;

  HeightRange({this.min, this.max});

  HeightRange.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    return data;
  }
}

// class AllMadelsData {
//   int? statusCode;
//   bool? success;
//   String? message;
//   List<AllMadels>? data;

//   AllMadelsData({this.statusCode, this.success, this.message, this.data});

//   AllMadelsData.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'] as int?;
//     success = json['success'] as bool?;
//     message = json['message'] as String?;
//     if (json['data'] != null) {
//       data = <AllMadels>[];
//       json['data'].forEach((v) {
//         data!.add(AllMadels.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['statusCode'] = statusCode;
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AllMadels {
//   String? sId;
//   String? title;
//   int? targetDistance;
//   String? img;
//   bool? isDeleted;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   AllMadels({
//     this.sId,
//     this.title,
//     this.targetDistance,
//     this.img,
//     this.isDeleted,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });

//   AllMadels.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'] as String?;
//     title = json['title'] as String?;
//     targetDistance = json['targetDistance'] as int?;
//     img = json['img'] as String?;
//     isDeleted = json['isDeleted'] as bool?;
//     createdAt = json['createdAt'] as String?;
//     updatedAt = json['updatedAt'] as String?;
//     iV = json['__v'] as int?;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['title'] = title;
//     data['targetDistance'] = targetDistance;
//     data['img'] = img;
//     data['isDeleted'] = isDeleted;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }



class AllMadelsData {
  int? statusCode;
  bool? success;
  String? message;
  List<AllMadels>? data;

  AllMadelsData({this.statusCode, this.success, this.message, this.data});

  AllMadelsData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'] as int?;
    success = json['success'] as bool?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <AllMadels>[];
      json['data'].forEach((v) {
        data!.add(AllMadels.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllMadels {
  String? sId;
  String? title;
  int? disLowerLimit; // Changed from targetDistance to disLowerLimit
  int? disUpperLimit; // Added disUpperLimit
  String? img;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AllMadels({
    this.sId,
    this.title,
    this.disLowerLimit,  // Updated
    this.disUpperLimit,  // Added
    this.img,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AllMadels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    title = json['title'] as String?;
    disLowerLimit = json['disLowerLimit'] as int?;  // Updated
    disUpperLimit = json['disUpperLimit'] as int?;  // Added
    img = json['img'] as String?;
    isDeleted = json['isDeleted'] as bool?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    iV = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['disLowerLimit'] = disLowerLimit; // Updated
    data['disUpperLimit'] = disUpperLimit; // Added
    data['img'] = img;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

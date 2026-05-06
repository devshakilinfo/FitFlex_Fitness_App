class AllMadelsData {
  int? statusCode;
  bool? success;
  String? message;
  List<AllMadels>? data;

  AllMadelsData({this.statusCode, this.success, this.message, this.data});

  AllMadelsData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllMadels>[];
      json['data'].forEach((v) {
        data!.add(AllMadels.fromJson(v));
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
  String? description;
  String? domain;
  int? maxDistance;
  String? maxTime;
  String? recordBreakType;
  int? daysInRow;
  String? img;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iv;

  AllMadels({
    this.sId,
    this.title,
    this.description,
    this.domain,
    this.maxDistance,
    this.maxTime,
    this.recordBreakType,
    this.daysInRow,
    this.img,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iv,
  });

  AllMadels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    domain = json['domain'];
    maxDistance = json['maxDistance'];
    maxTime = json['maxTime'];
    recordBreakType = json['recordBreakType'];
    daysInRow = json['daysInRow'];
    img = json['img'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iv = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['domain'] = domain;
    data['maxDistance'] = maxDistance;
    data['maxTime'] = maxTime;
    data['recordBreakType'] = recordBreakType;
    data['daysInRow'] = daysInRow;
    data['img'] = img;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iv;
    return data;
  }
}

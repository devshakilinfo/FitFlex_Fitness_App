class HistoryModel {
  bool? success;
  String? message;
  List<Data>? data;

  HistoryModel({this.success, this.message, this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success ?? false;
    data['message'] = message ?? '';
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  int? runningGoal;
  bool? firstRotation;
  String? startingTime;
  String? currenttime;
  String? timeDuration;
  bool? hasStared;
  String? status;
  double? pointOneLongatitude;
  double? pointOneLatitude;
  double? pointTwoLongatitude;
  double? pointTwoLatitude;
  double? distanceCovered;
  int? flightClimed;
  double? distanceRamaining;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.userId,
    this.runningGoal,
    this.firstRotation,
    this.startingTime,
    this.currenttime,
    this.timeDuration,
    this.hasStared,
    this.status,
    this.pointOneLongatitude,
    this.pointOneLatitude,
    this.pointTwoLongatitude,
    this.pointTwoLatitude,
    this.distanceCovered,
    this.flightClimed,
    this.distanceRamaining,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    userId = json['user_id'] ?? '';
    runningGoal = json['running_Goal'] ?? 0;
    firstRotation = json['firstRotation'];
    startingTime = json['starting_time'] ?? '';
    currenttime = json['currenttime'] ?? '';
    timeDuration = json['timeDuration'] ?? '';
    hasStared = json['has_Stared'] ?? false;
    status = json['status'] ?? '';
    pointOneLongatitude = json['pointOne_longatitude']?.toDouble() ?? 0.0;
    pointOneLatitude = json['pointOne_latitude']?.toDouble() ?? 0.0;
    pointTwoLongatitude = json['pointTwo_longatitude']?.toDouble() ?? 0.0;
    pointTwoLatitude = json['pointTwo_latitude']?.toDouble() ?? 0.0;
    distanceCovered = json['distance_covered']?.toDouble() ?? 0.0;
    flightClimed = json['flight_climed'] ?? 0;
    distanceRamaining = json['distance_ramaining']?.toDouble() ?? 0.0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId ?? '';
    data['user_id'] = userId ?? '';
    data['running_Goal'] = runningGoal ?? 0;
    data['firstRotation'] = firstRotation;
    data['starting_time'] = startingTime ?? '';
    data['currenttime'] = currenttime ?? '';
    data['timeDuration'] = timeDuration ?? '';
    data['has_Stared'] = hasStared ?? false;
    data['status'] = status ?? '';
    data['pointOne_longatitude'] = pointOneLongatitude ?? 0.0;
    data['pointOne_latitude'] = pointOneLatitude ?? 0.0;
    data['pointTwo_longatitude'] = pointTwoLongatitude ?? 0.0;
    data['pointTwo_latitude'] = pointTwoLatitude ?? 0.0;
    data['distance_covered'] = distanceCovered ?? 0.0;
    data['flight_climed'] = flightClimed ?? 0;
    data['distance_ramaining'] = distanceRamaining ?? 0.0;
    data['createdAt'] = createdAt ?? '';
    data['updatedAt'] = updatedAt ?? '';
    data['__v'] = iV ?? 0;
    return data;
  }
}

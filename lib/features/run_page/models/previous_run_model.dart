class PreviousRunModel {
  final bool success;
  final String message;
  final Data data;

  PreviousRunModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PreviousRunModel.fromJson(Map<String, dynamic> json) {
    return PreviousRunModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class Data {
  final String message;
  final DataDetails data;

  Data({required this.message, required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'] ?? '',
      data: DataDetails.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.toJson()};
  }
}

class DataDetails {
  final double fractionalTime;
  final String id;
  final String userId;
  final int runningGoal;
  final bool firstRotation;
  final int startingTime;
  final int currentTime;
  final String timeDuration;
  final bool hasStarted;
  final String status;
  final double pointOneLongitude;
  final double pointOneLatitude;
  final double pointTwoLongitude;
  final double pointTwoLatitude;
  final double distanceCovered;
  final double flightClimbed;
  final double distanceRemaining;
  final String createdAt;
  final String updatedAt;
  final int v;

  DataDetails({
    required this.fractionalTime,
    required this.id,
    required this.userId,
    required this.runningGoal,
    required this.firstRotation,
    required this.startingTime,
    required this.currentTime,
    required this.timeDuration,
    required this.hasStarted,
    required this.status,
    required this.pointOneLongitude,
    required this.pointOneLatitude,
    required this.pointTwoLongitude,
    required this.pointTwoLatitude,
    required this.distanceCovered,
    required this.flightClimbed,
    required this.distanceRemaining,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    return DataDetails(
      fractionalTime: json['fractionalTime']?.toDouble() ?? 0.0,
      id: json['_id'] ?? '',
      userId: json['user_id'] ?? '',
      runningGoal: json['running_Goal'] ?? 0,
      firstRotation: json['firstRotation'] ?? false,
      startingTime: json['starting_time'] ?? 0,
      currentTime: json['currenttime'] ?? 0,
      timeDuration: json['timeDuration'] ?? '',
      hasStarted: json['has_Stared'] ?? false,
      status: json['status'] ?? '',
      pointOneLongitude: json['pointOne_longatitude']?.toDouble() ?? 0.0,
      pointOneLatitude: json['pointOne_latitude']?.toDouble() ?? 0.0,
      pointTwoLongitude: json['pointTwo_longatitude']?.toDouble() ?? 0.0,
      pointTwoLatitude: json['pointTwo_latitude']?.toDouble() ?? 0.0,
      distanceCovered: json['distance_covered']?.toDouble() ?? 0.0,
      flightClimbed: json['flight_climed']?.toDouble() ?? 0.0,
      distanceRemaining: json['distance_ramaining']?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fractionalTime': fractionalTime,
      '_id': id,
      'user_id': userId,
      'running_Goal': runningGoal,
      'firstRotation': firstRotation,
      'starting_time': startingTime,
      'currenttime': currentTime,
      'timeDuration': timeDuration,
      'has_Stared': hasStarted,
      'status': status,
      'pointOne_longatitude': pointOneLongitude,
      'pointOne_latitude': pointOneLatitude,
      'pointTwo_longatitude': pointTwoLongitude,
      'pointTwo_latitude': pointTwoLatitude,
      'distance_covered': distanceCovered,
      'flight_climed': flightClimbed,
      'distance_ramaining': distanceRemaining,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

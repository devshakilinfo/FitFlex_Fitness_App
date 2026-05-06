class LeaderBoardPositionModel {
  bool success;
  String message;
  LeaderBoardData data;

  LeaderBoardPositionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LeaderBoardPositionModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardPositionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: LeaderBoardData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class LeaderBoardData {
  int position;
  int nextPosition;
  double distanceToNext;

  LeaderBoardData({
    required this.position,
    required this.nextPosition,
    required this.distanceToNext,
  });

  factory LeaderBoardData.fromJson(Map<String, dynamic> json) {
    return LeaderBoardData(
      position: json['position'] ?? 0,
      nextPosition: json['nextPosition'] ?? 0,
      distanceToNext: (json['distanceToNext'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'nextPosition': nextPosition,
      'distanceToNext': distanceToNext,
    };
  }
}

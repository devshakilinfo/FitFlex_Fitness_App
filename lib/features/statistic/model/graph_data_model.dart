class Meta {
  final int totalRuns;
  final double totalDistance;
  final String totalDuration;
  final int avgLbPosition;

  Meta({
    required this.totalRuns,
    required this.totalDistance,
    required this.totalDuration,
    required this.avgLbPosition,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalRuns:
          json['totalRuns'] is String
              ? int.tryParse(json['totalRuns']) ?? 0
              : json['totalRuns'],
      totalDistance:
          json['totalDistance'] is String
              ? double.tryParse(json['totalDistance']) ?? 0.0
              : json['totalDistance'].toDouble(),
      totalDuration:
          json['totalDuration'] is String
              ? json['totalDuration']
              : json['totalDuration'].toString(),
      avgLbPosition:
          json['avg_LB_position'] is String
              ? int.tryParse(json['avg_LB_position']) ?? 0
              : json['avg_LB_position'],
    );
  }
}

// GraphData class (individual graph entry structure)
class GraphData {
  final String date;
  final double distance;
  final String dayOfWeek;
  final String duration;
  final int? lbPosition;

  GraphData({
    required this.date,
    required this.distance,
    required this.dayOfWeek,
    required this.duration,
    this.lbPosition,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      date: json['date'],
      distance: json['distance'].toDouble(),
      dayOfWeek: json['dayOfWeek'],
      duration: json['duration'],
      // ignore: prefer_if_null_operators
      lbPosition: json['LB_position'] != null ? json['LB_position'] : null,
    );
  }
}

// GraphResponse class (main response structure)
class GraphResponse {
  final bool success;
  final String message;
  final List<GraphData> graphData;
  final Meta meta;

  GraphResponse({
    required this.success,
    required this.message,
    required this.graphData,
    required this.meta,
  });

  factory GraphResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['data']['Graph_Data'] as List;
    List<GraphData> graphDataList =
        list.map((i) => GraphData.fromJson(i)).toList();
    Meta metaData = Meta.fromJson(json['data']['data']['meta']);

    return GraphResponse(
      success: json['success'],
      message: json['message'],
      graphData: graphDataList,
      meta: metaData,
    );
  }
}

class GetLeaderBoard {
  String? sId;
  String? name;
  String? img;
  String? lBPosition;
  String? totalDistanceCrossed;

  GetLeaderBoard({
    this.sId,
    this.name,
    this.img,
    this.lBPosition,
    this.totalDistanceCrossed,
  });

  GetLeaderBoard.fromJson(Map<String, dynamic> json) {
    sId = json['_id']?.toString();
    name = json['name']?.toString();
    img = json['img']?.toString();
    lBPosition = json['LB_Position']?.toString();
    totalDistanceCrossed = json['total_distance_crossed']?.toString();
  }
}

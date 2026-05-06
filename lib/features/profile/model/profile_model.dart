// model/user_profile.dart

class UserProfile {
  final String id;
  final String name;
  final String email;
  final int lbPosition;
  final int totalDistanceCrossed;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? residenceArea;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.lbPosition,
    required this.totalDistanceCrossed,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.residenceArea,
  });

  // Factory method to create a UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      lbPosition: json['LB_Position'],
      totalDistanceCrossed: json['total_distance_crossed'],
      age: json['age'],
      gender: json['gender'],
      height: json['hight'],
      weight: json['weight'],
      residenceArea: json['recidenceArea'],
    );
  }
}

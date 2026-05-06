class AllUser {
  bool? success;
  String? message;
  List<AllData>? data;

  AllUser({this.success, this.message, this.data});

  // From JSON constructor
  AllUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = (json['data'] as List).map((v) => AllData.fromJson(v)).toList();
    }
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllData {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  bool? agreedToTerms; // fixed typo: "aggriedToterms"
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? passwordChangeTime;

  AllData({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.role,
    this.agreedToTerms,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.passwordChangeTime,
  });

  // From JSON constructor
  AllData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    agreedToTerms = json['aggriedToterms']; // fixed typo: "aggriedToterms"
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    isLoggedIn = json['isLoggedIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    passwordChangeTime = json['passwordChangeTime'];
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['aggriedToterms'] = agreedToTerms; // fixed typo: "aggriedToterms"
    data['isDeleted'] = isDeleted;
    data['isBlocked'] = isBlocked;
    data['isLoggedIn'] = isLoggedIn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['passwordChangeTime'] = passwordChangeTime;
    return data;
  }
}

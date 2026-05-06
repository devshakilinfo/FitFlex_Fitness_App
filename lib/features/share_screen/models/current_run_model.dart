
class CurrentRun {
bool? success;
String? message;
Data? data;

CurrentRun({this.success, this.message, this.data});

CurrentRun.fromJson(Map<String, dynamic> json) {
success = json['success'];
message = json['message'];
data = json['data'] != null ? Data.fromJson(json['data']) : null;
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['success'] = success;
data['message'] = message;
if (this.data != null) {
data['data'] = this.data!.toJson();
}
return data;
}
}

class Data {
String? sId;
String? name;
String? email;
String? img;
double? maxSpeed;
double? maxDistance;
int? age;
String? gender;
String? height;
String? weight;
String? residenceArea;
String? userId;
int? lbPosition;
num? totalDistanceCrossed;
int? totalAttempted;
int? totalMedalAchieved;
List<RunAttemptedId>? runAttemptedId;
List<FavMeal>? favMeal;
List<MedalAchieved>? medalAchieved;
List<SharedProgress>? sharedProgress;
bool? isDeleted;
String? createdAt;
String? updatedAt;
int? iv;

Data({
this.sId,
this.name,
this.email,
this.img,
this.maxSpeed,
this.maxDistance,
this.age,
this.gender,
this.height,
this.weight,
this.residenceArea,
this.userId,
this.lbPosition,
this.totalDistanceCrossed,
this.totalAttempted,
this.totalMedalAchieved,
this.runAttemptedId,
this.favMeal,
this.medalAchieved,
this.sharedProgress,
this.isDeleted,
this.createdAt,
this.updatedAt,
this.iv,
});

Data.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
name = json['name'];
email = json['email'];
img = json['img'];
maxSpeed = json['maxSpeed']?.toDouble();
maxDistance = json['maxDistence']?.toDouble();
age = json['age'];
gender = json['gender'];
height = json['hight'];
weight = json['weight'];
residenceArea = json['recidenceArea'];
userId = json['user_id'];
lbPosition = json['LB_Position'];
totalDistanceCrossed = json['total_distance_crossed'];
totalAttempted = json['total_attempted'];
totalMedalAchieved = json['totalMedalAchived'] ?? json['totalMedalAchieved'];

if (json['run_attempted_id'] != null) {
runAttemptedId = <RunAttemptedId>[];
json['run_attempted_id'].forEach((v) {
runAttemptedId!.add(RunAttemptedId.fromJson(v));
});
}
if (json['fev_meal'] != null) {
favMeal = <FavMeal>[];
json['fev_meal'].forEach((v) {
favMeal!.add(FavMeal.fromJson(v));
});
}
if (json['madel_Achived'] != null || json['medal_Achieved'] != null) {
medalAchieved = <MedalAchieved>[];
var medalList = json['madel_Achived'] ?? json['medal_Achieved'];
medalList.forEach((v) {
medalAchieved!.add(MedalAchieved.fromJson(v));
});
}
if (json['sharedProgress'] != null) {
sharedProgress = <SharedProgress>[];
json['sharedProgress'].forEach((v) {
sharedProgress!.add(SharedProgress.fromJson(v));
});
}
isDeleted = json['isDeleted'];
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
iv = json['__v'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['_id'] = sId;
data['name'] = name;
data['email'] = email;
data['img'] = img;
data['maxSpeed'] = maxSpeed;
data['maxDistence'] = maxDistance;
data['age'] = age;
data['gender'] = gender;
data['hight'] = height;
data['weight'] = weight;
data['recidenceArea'] = residenceArea;
data['user_id'] = userId;
data['LB_Position'] = lbPosition;
data['total_distance_crossed'] = totalDistanceCrossed;
data['total_attempted'] = totalAttempted;
data['totalMedalAchieved'] = totalMedalAchieved;
if (runAttemptedId != null) {
data['run_attempted_id'] = runAttemptedId!.map((v) => v.toJson()).toList();
}
if (favMeal != null) {
data['fev_meal'] = favMeal!.map((v) => v.toJson()).toList();
}
if (medalAchieved != null) {
data['medal_Achieved'] = medalAchieved!.map((v) => v.toJson()).toList();
}
if (sharedProgress != null) {
data['sharedProgress'] = sharedProgress!.map((v) => v.toJson()).toList();
}
data['isDeleted'] = isDeleted;
data['createdAt'] = createdAt;
data['updatedAt'] = updatedAt;
data['__v'] = iv;
return data;
}
}

class RunAttemptedId {
String? sId;
String? userId;
int? runningGoal;
bool? firstRotation;
String? startingTime;
String? currentTime;
String? timeDuration;
bool? hasStarted;
String? status;
num? pointOneLongitude;
num? pointOneLatitude;
num? pointTwoLongitude;
num? pointTwoLatitude;
num? distanceCovered;
int? flightClimbed;
num? distanceRemaining;
String? createdAt;
String? updatedAt;
int? iv;

RunAttemptedId({
this.sId,
this.userId,
this.runningGoal,
this.firstRotation,
this.startingTime,
this.currentTime,
this.timeDuration,
this.hasStarted,
this.status,
this.pointOneLongitude,
this.pointOneLatitude,
this.pointTwoLongitude,
this.pointTwoLatitude,
this.distanceCovered,
this.flightClimbed,
this.distanceRemaining,
this.createdAt,
this.updatedAt,
this.iv,
});

RunAttemptedId.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
userId = json['user_id'];
runningGoal = json['running_Goal'];
firstRotation = json['firstRotation'];
startingTime = json['starting_time'];
currentTime = json['currenttime'];
timeDuration = json['timeDuration'];
hasStarted = json['has_Stared'];
status = json['status'];
pointOneLongitude = json['pointOne_longitude'];
pointOneLatitude = json['pointOne_latitude'];
pointTwoLongitude = json['pointTwo_longitude'];
pointTwoLatitude = json['pointTwo_latitude'];
distanceCovered = json['distance_covered'];
flightClimbed = json['flight_climed'];
distanceRemaining = json['distance_remaining'] ?? json['distance_ramaining'];
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
iv = json['__v'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['_id'] = sId;
data['user_id'] = userId;
data['running_Goal'] = runningGoal;
data['firstRotation'] = firstRotation;
data['starting_time'] = startingTime;
data['currenttime'] = currentTime;
data['timeDuration'] = timeDuration;
data['has_Stared'] = hasStarted;
data['status'] = status;
data['pointOne_longitude'] = pointOneLongitude;
data['pointOne_latitude'] = pointOneLatitude;
data['pointTwo_longitude'] = pointTwoLongitude;
data['pointTwo_latitude'] = pointTwoLatitude;
data['distance_covered'] = distanceCovered;
data['flight_climed'] = flightClimbed;
data['distance_remaining'] = distanceRemaining;
data['createdAt'] = createdAt;
data['updatedAt'] = updatedAt;
data['__v'] = iv;
return data;
}
}

class FavMeal {
String? sId;
String? title;
String? description;
String? fitnessLevel;
String? image;
List<String>? breakfast;
List<String>? lunch;
List<String>? dinner;
HeightRange? heightRange;
WeightRange? weightRange;
String? createdAt;
String? updatedAt;
int? iv;

FavMeal({
this.sId,
this.title,
this.description,
this.fitnessLevel,
this.image,
this.breakfast,
this.lunch,
this.dinner,
this.heightRange,
this.weightRange,
this.createdAt,
this.updatedAt,
this.iv,
});

FavMeal.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
title = json['title'];
description = json['description'];
fitnessLevel = json['fitnessLevel'];
image = json['image'];
breakfast = json['breakfast']?.cast<String>();
lunch = json['lunch']?.cast<String>();
dinner = json['dinner']?.cast<String>();
heightRange = json['heightRange'] != null
? HeightRange.fromJson(json['heightRange'])
    : null;
weightRange = json['weightRange'] != null
? WeightRange.fromJson(json['weightRange'])
    : null;
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
iv = json['__v'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['_id'] = sId;
data['title'] = title;
data['description'] = description;
data['fitnessLevel'] = fitnessLevel;
data['image'] = image;
data['breakfast'] = breakfast;
data['lunch'] = lunch;
data['dinner'] = dinner;
if (heightRange != null) {
data['heightRange'] = heightRange!.toJson();
}
if (weightRange != null) {
data['weightRange'] = weightRange!.toJson();
}
data['createdAt'] = createdAt;
data['updatedAt'] = updatedAt;
data['__v'] = iv;
return data;
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

class WeightRange {
int? min;
int? max;

WeightRange({this.min, this.max});

WeightRange.fromJson(Map<String, dynamic> json) {
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

class SharedProgress {
String? progressId;
String? userId;
String? progressStatus;
String? createdAt;
String? updatedAt;

SharedProgress({
this.progressId,
this.userId,
this.progressStatus,
this.createdAt,
this.updatedAt,
});

SharedProgress.fromJson(Map<String, dynamic> json) {
progressId = json['_id'];
userId = json['user_id'];
progressStatus = json['progress_status'];
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['_id'] = progressId;
data['user_id'] = userId;
data['progress_status'] = progressStatus;
data['createdAt'] = createdAt;
data['updatedAt'] = updatedAt;
return data;
}
}

class MedalAchieved {
String? sId;
MedalId? medalId;
int? count;

MedalAchieved({this.sId, this.medalId, this.count});

MedalAchieved.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
medalId = json['medel_id'] != null ? MedalId.fromJson(json['medel_id']) : null;
count = json['count'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = <String, dynamic>{};
data['_id'] = sId;
if (medalId != null) {
data['medel_id'] = medalId!.toJson();
}
data['count'] = count;
return data;
}
}

class MedalId {
String? sId;
String? title;
String? description;
String? domain;
String? recordBreakType;
int? maxDistance;
String? maxTime;
int? daysInRow;
String? img;
bool? isDeleted;
String? createdAt;
String? updatedAt;
int? iv;

MedalId({
this.sId,
this.title,
this.description,
this.domain,
this.recordBreakType,
this.maxDistance,
this.maxTime,
this.daysInRow,
this.img,
this.isDeleted,
this.createdAt,
this.updatedAt,
this.iv,
});

MedalId.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
title = json['title'];
description = json['description'];
domain = json['domain'];
recordBreakType = json['recordBreakType'];
maxDistance = json['maxDistance'];
maxTime = json['maxTime'];
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
data['recordBreakType'] = recordBreakType;
data['maxDistance'] = maxDistance;
data['maxTime'] = maxTime;
data['daysInRow'] = daysInRow;
data['img'] = img;
data['isDeleted'] = isDeleted;
data['createdAt'] = createdAt;
data['updatedAt'] = updatedAt;
data['__v'] = iv;
return data;
}
}

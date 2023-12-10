import 'dart:convert';

ActivityData activityDataFromJson(String str) => ActivityData.fromJson(json.decode(str));

String activityDataToJson(ActivityData data) => json.encode(data.toJson());

class ActivityData {
  List<dynamic> activities;
  Goals goals;
  Summary summary;

  ActivityData({
    required this.activities,
    required this.goals,
    required this.summary,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) => ActivityData(
    activities: List<dynamic>.from(json["activities"].map((x) => x)),
    goals: Goals.fromJson(json["goals"]),
    summary: Summary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "activities": List<dynamic>.from(activities.map((x) => x)),
    "goals": goals.toJson(),
    "summary": summary.toJson(),
  };
}

class Goals {
  int activeMinutes;
  int caloriesOut;
  double distance;
  int floors;
  int steps;

  Goals({
    required this.activeMinutes,
    required this.caloriesOut,
    required this.distance,
    required this.floors,
    required this.steps,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
    activeMinutes: json["activeMinutes"],
    caloriesOut: json["caloriesOut"],
    distance: json["distance"]?.toDouble(),
    floors: json["floors"],
    steps: json["steps"],
  );

  Map<String, dynamic> toJson() => {
    "activeMinutes": activeMinutes,
    "caloriesOut": caloriesOut,
    "distance": distance,
    "floors": floors,
    "steps": steps,
  };
}

class Summary {
  int activeScore;
  int activityCalories;
  int calorieEstimationMu;
  int caloriesBmr;
  int caloriesOut;
  int caloriesOutUnestimated;
  List<Distance> distances;
  double elevation;
  int fairlyActiveMinutes;
  int floors;
  List<HeartRateZone> heartRateZones;
  int lightlyActiveMinutes;
  int marginalCalories;
  int restingHeartRate;
  int sedentaryMinutes;
  int steps;
  bool useEstimation;
  int veryActiveMinutes;

  Summary({
    required this.activeScore,
    required this.activityCalories,
    required this.calorieEstimationMu,
    required this.caloriesBmr,
    required this.caloriesOut,
    required this.caloriesOutUnestimated,
    required this.distances,
    required this.elevation,
    required this.fairlyActiveMinutes,
    required this.floors,
    required this.heartRateZones,
    required this.lightlyActiveMinutes,
    required this.marginalCalories,
    required this.restingHeartRate,
    required this.sedentaryMinutes,
    required this.steps,
    required this.useEstimation,
    required this.veryActiveMinutes,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    activeScore: json["activeScore"],
    activityCalories: json["activityCalories"],
    calorieEstimationMu: json["calorieEstimationMu"],
    caloriesBmr: json["caloriesBMR"],
    caloriesOut: json["caloriesOut"],
    caloriesOutUnestimated: json["caloriesOutUnestimated"],
    distances: List<Distance>.from(json["distances"].map((x) => Distance.fromJson(x))),
    elevation: json["elevation"]?.toDouble(),
    fairlyActiveMinutes: json["fairlyActiveMinutes"],
    floors: json["floors"],
    heartRateZones: List<HeartRateZone>.from(json["heartRateZones"].map((x) => HeartRateZone.fromJson(x))),
    lightlyActiveMinutes: json["lightlyActiveMinutes"],
    marginalCalories: json["marginalCalories"],
    restingHeartRate: json["restingHeartRate"],
    sedentaryMinutes: json["sedentaryMinutes"],
    steps: json["steps"],
    useEstimation: json["useEstimation"],
    veryActiveMinutes: json["veryActiveMinutes"],
  );

  Map<String, dynamic> toJson() => {
    "activeScore": activeScore,
    "activityCalories": activityCalories,
    "calorieEstimationMu": calorieEstimationMu,
    "caloriesBMR": caloriesBmr,
    "caloriesOut": caloriesOut,
    "caloriesOutUnestimated": caloriesOutUnestimated,
    "distances": List<dynamic>.from(distances.map((x) => x.toJson())),
    "elevation": elevation,
    "fairlyActiveMinutes": fairlyActiveMinutes,
    "floors": floors,
    "heartRateZones": List<dynamic>.from(heartRateZones.map((x) => x.toJson())),
    "lightlyActiveMinutes": lightlyActiveMinutes,
    "marginalCalories": marginalCalories,
    "restingHeartRate": restingHeartRate,
    "sedentaryMinutes": sedentaryMinutes,
    "steps": steps,
    "useEstimation": useEstimation,
    "veryActiveMinutes": veryActiveMinutes,
  };
}

class Distance {
  String activity;
  double distance;

  Distance({
    required this.activity,
    required this.distance,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    activity: json["activity"],
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
    "distance": distance,
  };
}

class HeartRateZone {
  double caloriesOut;
  int max;
  int min;
  int minutes;
  String name;

  HeartRateZone({
    required this.caloriesOut,
    required this.max,
    required this.min,
    required this.minutes,
    required this.name,
  });

  factory HeartRateZone.fromJson(Map<String, dynamic> json) => HeartRateZone(
    caloriesOut: json["caloriesOut"]?.toDouble(),
    max: json["max"],
    min: json["min"],
    minutes: json["minutes"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "caloriesOut": caloriesOut,
    "max": max,
    "min": min,
    "minutes": minutes,
    "name": name,
  };
}
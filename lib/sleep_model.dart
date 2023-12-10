import 'dart:convert';

SleepData sleepDataFromJson(String str) => SleepData.fromJson(json.decode(str));

String sleepDataToJson(SleepData data) => json.encode(data.toJson());

class SleepData {
  List<Sleep> sleep;
  SleepDataSummary summary;

  SleepData({
    required this.sleep,
    required this.summary,
  });

  factory SleepData.fromJson(Map<String, dynamic> json) => SleepData(
    sleep: List<Sleep>.from(json["sleep"].map((x) => Sleep.fromJson(x))),
    summary: SleepDataSummary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "sleep": List<dynamic>.from(sleep.map((x) => x.toJson())),
    "summary": summary.toJson(),
  };
}

class Sleep {
  DateTime dateOfSleep;
  int duration;
  int efficiency;
  DateTime endTime;
  int infoCode;
  bool isMainSleep;
  Levels levels;
  int logId;
  String logType;
  int minutesAfterWakeup;
  int minutesAsleep;
  int minutesAwake;
  int minutesToFallAsleep;
  DateTime startTime;
  int timeInBed;
  String type;

  Sleep({
    required this.dateOfSleep,
    required this.duration,
    required this.efficiency,
    required this.endTime,
    required this.infoCode,
    required this.isMainSleep,
    required this.levels,
    required this.logId,
    required this.logType,
    required this.minutesAfterWakeup,
    required this.minutesAsleep,
    required this.minutesAwake,
    required this.minutesToFallAsleep,
    required this.startTime,
    required this.timeInBed,
    required this.type,
  });

  factory Sleep.fromJson(Map<String, dynamic> json) => Sleep(
    dateOfSleep: DateTime.parse(json["dateOfSleep"]),
    duration: json["duration"],
    efficiency: json["efficiency"],
    endTime: DateTime.parse(json["endTime"]),
    infoCode: json["infoCode"],
    isMainSleep: json["isMainSleep"],
    levels: Levels.fromJson(json["levels"]),
    logId: json["logId"],
    logType: json["logType"],
    minutesAfterWakeup: json["minutesAfterWakeup"],
    minutesAsleep: json["minutesAsleep"],
    minutesAwake: json["minutesAwake"],
    minutesToFallAsleep: json["minutesToFallAsleep"],
    startTime: DateTime.parse(json["startTime"]),
    timeInBed: json["timeInBed"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "dateOfSleep": "${dateOfSleep.year.toString().padLeft(4, '0')}-${dateOfSleep.month.toString().padLeft(2, '0')}-${dateOfSleep.day.toString().padLeft(2, '0')}",
    "duration": duration,
    "efficiency": efficiency,
    "endTime": endTime.toIso8601String(),
    "infoCode": infoCode,
    "isMainSleep": isMainSleep,
    "levels": levels.toJson(),
    "logId": logId,
    "logType": logType,
    "minutesAfterWakeup": minutesAfterWakeup,
    "minutesAsleep": minutesAsleep,
    "minutesAwake": minutesAwake,
    "minutesToFallAsleep": minutesToFallAsleep,
    "startTime": startTime.toIso8601String(),
    "timeInBed": timeInBed,
    "type": type,
  };
}

class Levels {
  List<Datum> data;
  List<Datum> shortData;
  LevelsSummary summary;

  Levels({
    required this.data,
    required this.shortData,
    required this.summary,
  });

  factory Levels.fromJson(Map<String, dynamic> json) => Levels(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    shortData: List<Datum>.from(json["shortData"].map((x) => Datum.fromJson(x))),
    summary: LevelsSummary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "shortData": List<dynamic>.from(shortData.map((x) => x.toJson())),
    "summary": summary.toJson(),
  };
}

class Datum {
  DateTime dateTime;
  Level level;
  int seconds;

  Datum({
    required this.dateTime,
    required this.level,
    required this.seconds,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dateTime: DateTime.parse(json["dateTime"]),
    level: levelValues.map[json["level"]]!,
    seconds: json["seconds"],
  );

  Map<String, dynamic> toJson() => {
    "dateTime": dateTime.toIso8601String(),
    "level": levelValues.reverse[level],
    "seconds": seconds,
  };
}

enum Level {
  DEEP,
  LIGHT,
  REM,
  WAKE
}

final levelValues = EnumValues({
  "deep": Level.DEEP,
  "light": Level.LIGHT,
  "rem": Level.REM,
  "wake": Level.WAKE
});

class LevelsSummary {
  Deep deep;
  Deep light;
  Deep rem;
  Deep wake;

  LevelsSummary({
    required this.deep,
    required this.light,
    required this.rem,
    required this.wake,
  });

  factory LevelsSummary.fromJson(Map<String, dynamic> json) => LevelsSummary(
    deep: Deep.fromJson(json["deep"]),
    light: Deep.fromJson(json["light"]),
    rem: Deep.fromJson(json["rem"]),
    wake: Deep.fromJson(json["wake"]),
  );

  Map<String, dynamic> toJson() => {
    "deep": deep.toJson(),
    "light": light.toJson(),
    "rem": rem.toJson(),
    "wake": wake.toJson(),
  };
}

class Deep {
  int count;
  int minutes;
  int thirtyDayAvgMinutes;

  Deep({
    required this.count,
    required this.minutes,
    required this.thirtyDayAvgMinutes,
  });

  factory Deep.fromJson(Map<String, dynamic> json) => Deep(
    count: json["count"],
    minutes: json["minutes"],
    thirtyDayAvgMinutes: json["thirtyDayAvgMinutes"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "minutes": minutes,
    "thirtyDayAvgMinutes": thirtyDayAvgMinutes,
  };
}

class SleepDataSummary {
  Stages stages;
  int totalMinutesAsleep;
  int totalSleepRecords;
  int totalTimeInBed;

  SleepDataSummary({
    required this.stages,
    required this.totalMinutesAsleep,
    required this.totalSleepRecords,
    required this.totalTimeInBed,
  });

  factory SleepDataSummary.fromJson(Map<String, dynamic> json) => SleepDataSummary(
    stages: Stages.fromJson(json["stages"]),
    totalMinutesAsleep: json["totalMinutesAsleep"],
    totalSleepRecords: json["totalSleepRecords"],
    totalTimeInBed: json["totalTimeInBed"],
  );

  Map<String, dynamic> toJson() => {
    "stages": stages.toJson(),
    "totalMinutesAsleep": totalMinutesAsleep,
    "totalSleepRecords": totalSleepRecords,
    "totalTimeInBed": totalTimeInBed,
  };
}

class Stages {
  int deep;
  int light;
  int rem;
  int wake;

  Stages({
    required this.deep,
    required this.light,
    required this.rem,
    required this.wake,
  });

  factory Stages.fromJson(Map<String, dynamic> json) => Stages(
    deep: json["deep"],
    light: json["light"],
    rem: json["rem"],
    wake: json["wake"],
  );

  Map<String, dynamic> toJson() => {
    "deep": deep,
    "light": light,
    "rem": rem,
    "wake": wake,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
import 'dart:convert';

TemperatureData temperatureDataFromJson(String str) => TemperatureData.fromJson(json.decode(str));

String temperatureDataToJson(TemperatureData data) => json.encode(data.toJson());

class TemperatureData {
  List<TempSkin> tempSkin;

  TemperatureData({
    required this.tempSkin,
  });

  factory TemperatureData.fromJson(Map<String, dynamic> json) => TemperatureData(
    tempSkin: List<TempSkin>.from(json["tempSkin"].map((x) => TempSkin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tempSkin": List<dynamic>.from(tempSkin.map((x) => x.toJson())),
  };
}

class TempSkin {
  DateTime dateTime;
  Value value;
  String logType;

  TempSkin({
    required this.dateTime,
    required this.value,
    required this.logType,
  });

  factory TempSkin.fromJson(Map<String, dynamic> json) => TempSkin(
    dateTime: DateTime.parse(json["dateTime"]),
    value: Value.fromJson(json["value"]),
    logType: json["logType"],
  );

  Map<String, dynamic> toJson() => {
    "dateTime": "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
    "value": value.toJson(),
    "logType": logType,
  };
}

class Value {
  double nightlyRelative;

  Value({
    required this.nightlyRelative,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    nightlyRelative: json["nightlyRelative"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "nightlyRelative": nightlyRelative,
  };
}
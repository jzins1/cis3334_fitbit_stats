import 'package:cis3334_fitbit_stats/activity_model.dart';
import 'package:cis3334_fitbit_stats/sleep_model.dart';
import 'package:cis3334_fitbit_stats/temperature_model.dart';
import 'package:http/http.dart' as http;

// Fetch the activity data, which provides number of steps, active minutes, and resting heart rate
Future<Summary> fetchActivityData() async {
  final url = Uri.parse('https://api.fitbit.com/1/user/-/activities/date/2023-12-05.json');

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer API_KEY',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    ActivityData activityData = activityDataFromJson(response.body);
    return activityData.summary;
  } else {
    throw Exception('Failed to load Fitbit activity data');
  }
}

// Fetch the sleep data, which provides the total amount of sleep, wakefulness, and various stages
Future<SleepDataSummary> fetchSleepData() async {
  final url = Uri.parse('https://api.fitbit.com/1.2/user/-/sleep/date/2023-12-02.json');

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer API_KEY',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    SleepData sleepData = sleepDataFromJson(response.body);
    return sleepData.summary;
  } else {
    throw Exception('Failed to load Fitbit sleep data');
  }
}

// Fetch the temperature data, which provides the relative skin temperature from one's baseline
Future<List<TempSkin>> fetchTemperatureData() async {
  final url = Uri.parse('https://api.fitbit.com/1/user/-/temp/skin/date/2023-11-25.json');

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer API_KEY',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    TemperatureData temperatureData = temperatureDataFromJson(response.body);
    return temperatureData.tempSkin;
  } else {
    throw Exception('Failed to load Fitbit temperature data');
  }
}

// Note the specific Swagger UI selections are the following (search to find):
// GET /1/user/-/activities/date/{date}.json
// GET /1.2/user/-/sleep/date/{date}.json
// GET /1/user/-/temp/core/date/{date}.json
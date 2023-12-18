import 'package:flutter/material.dart';
import 'activity_model.dart';
import 'sleep_model.dart';
import 'temperature_model.dart';
import 'rest_api.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitbit Statistics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fitbit Statistics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // Initialize the API responses
  late Future<Summary> futureActivitySummaries;
  late Future<SleepDataSummary> futureSleepSummaries;
  late Future<List<TempSkin>> futureTemperatures;

  // Initialize the calendar
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // Set the API responses
    futureActivitySummaries = fetchActivityData("2023-12-05");
    futureSleepSummaries = fetchSleepData("2023-12-02");
    futureTemperatures = fetchTemperatureData("2023-12-13");
  }

  // void _incrementCounter() {
  //   setState(() {
  //     // _counter++;
  //   });
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // selectedDate = "${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}";
        print("Selected date is ${selectedDate}");
        futureActivitySummaries = fetchActivityData("2023-12-05");
        futureSleepSummaries = fetchSleepData("2023-12-02");
        futureTemperatures = fetchTemperatureData("2023-12-13");
      });
    }
  }

  String _convertMinToHrMin(int numMinutes) {
    int hours = (numMinutes / 60).floor();
    int minutes = numMinutes % 60;
    return (numMinutes >= 60) ? '${hours} hours ${minutes} minutes' : '${minutes} minutes';
  }

// API authenticated activity, heartrate, sleep, and temperature (note: heartrate needs authentication for resting HR in activity)
// I think I will display the activities (steps, active minutes (light and very active), resting heartrate)
// For sleep ((in hours and minutes) asleep, awake, light, deep, REM)
// For temperature, skin's relative temperature from baseline
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: 500,
        child: Column(
          children: [
            const Text(
              'Your Fitbit statistics:',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder(
              future: futureActivitySummaries,
              builder: (context, snapshot) {
                print("Entering builder");
                print("Snapshot is ${snapshot}");
                if (snapshot == null || snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                print("Snapshot is ${snapshot}");

                if(snapshot.data! == null) {
                  return Container();
                } else {
                  print("Snapshot is ${snapshot}");
                  Summary activitySummary = snapshot.data!;
                  print("Activity Minutes " + activitySummary.fairlyActiveMinutes.toString());
                  int totalActivityMinutes = activitySummary
                      .fairlyActiveMinutes +
                      activitySummary.veryActiveMinutes;

                  print("Snapshot is ${snapshot}");
                  return Center(
                    child: Column(
                      children: [
                        Text('Number of steps: ${activitySummary.steps
                            .toString()}'),
                        Text(
                          'Total minutes of activity: ${totalActivityMinutes} min '
                              '(${activitySummary.fairlyActiveMinutes
                              .toString()} min light and '
                              '${activitySummary.veryActiveMinutes
                              .toString()} min very active)',
                        ),
                        Text('Resting heart rate: ${activitySummary
                            .restingHeartRate} BPM'),
                      ],
                    ),
                  );
                }
              },
            ),
            FutureBuilder(
              future: futureSleepSummaries,
              builder: (context, snapshot) {
                if (snapshot == null || snapshot.connectionState == ConnectionState.none) {
                  return Container();
                }
                if (snapshot.data! == null) {
                  return Container();
                } else {
                  SleepDataSummary sleepSummary = snapshot.data!;

                  return Center(
                    child: Column(
                      children: [
                        Text('Total time in bed: ${_convertMinToHrMin(
                            sleepSummary.totalTimeInBed)}'),
                        Text('Total time asleep: ${_convertMinToHrMin(
                            sleepSummary.totalMinutesAsleep)}'),
                        Text('Total time awake: ${_convertMinToHrMin(
                            sleepSummary.stages.wake)}'),
                        Text('Total time in light sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.light)}'),
                        Text('Total time in deep sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.deep)}'),
                        Text('Total time in REM sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.rem)}'),
                      ],
                    ),
                  );
                }
              },
            ),
            FutureBuilder(
              future: futureTemperatures,
              builder: (context, snapshot) {
                if (snapshot == null || snapshot.connectionState == ConnectionState.none) {
                  return Container();
                }

                if(snapshot.data! == null) {
                  return Container();
                } else {
                  List<TempSkin> tempSkin = snapshot.data!;

                  return Center(
                    child: Column(
                      children: [
                        Text(
                            'Relative skin temperature (from baseline in degrees F): '
                                '${tempSkin[0].value.nightlyRelative
                                .toString()}'),
                      ],
                    ),
                  );
                }
              },
            ),
            Text(''),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
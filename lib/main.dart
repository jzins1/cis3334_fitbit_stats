import 'package:flutter/material.dart';
import 'activity_model.dart';
import 'sleep_model.dart';
import 'temperature_model.dart';
import 'rest_api.dart';
import 'package:intl/intl.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
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
  DateTime activityDate = DateTime.now();
  DateTime sleepDate = DateTime.now();
  DateTime tempDate = DateTime.now();

  @override
  void initState() {
    // Set the API responses
    DateTime currentDate = DateTime.now();
    futureActivitySummaries = fetchActivityData(_formatDate(currentDate));
    futureSleepSummaries = fetchSleepData(_formatDate(currentDate));
    futureTemperatures = fetchTemperatureData(_formatDate(currentDate));
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}";
  }

  Future<void> _selectActivityDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: activityDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != activityDate) {
      setState(() {
        activityDate = picked;
        futureActivitySummaries = fetchActivityData(_formatDate(activityDate));
      });
    }
  }

  Future<void> _selectSleepDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sleepDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sleepDate) {
      setState(() {
        sleepDate = picked;
        futureSleepSummaries = fetchSleepData(_formatDate(sleepDate));
      });
    }
  }

  Future<void> _selectTempDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tempDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != tempDate) {
      setState(() {
        futureTemperatures = fetchTemperatureData(_formatDate(tempDate));
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
        height: 1000,
        child: Column(
          children: [
            const Text(
              'Your Fitbit statistics:',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(''),
            ElevatedButton(
              onPressed: () => _selectActivityDate(context),
              child: const Text('Activity date'),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.orangeAccent,
              ),
            ),
            const Text(
              'Activity data:',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder(
              future: futureActivitySummaries,
              builder: (context, snapshot) {
                if (snapshot == null || snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                if(snapshot.data! == null) {
                  return Container();
                } else {
                  Summary activitySummary = snapshot.data!;
                  int totalActivityMinutes = activitySummary
                      .fairlyActiveMinutes +
                      activitySummary.veryActiveMinutes;

                  return Center(
                    child: Column(
                      children: [
                        // Text('Number of steps: ${activitySummary.steps
                        //     .toString()}'),
                        Text('Number of steps: ${activitySummary.steps
                            .toString()}', style: TextStyle(color: Colors.orange)),
                        Text(
                        'Total minutes of activity: ${totalActivityMinutes} min '
                        '(${activitySummary.fairlyActiveMinutes
                            .toString()} min light and '
                        '${activitySummary.veryActiveMinutes
                            .toString()} min very active)', style: TextStyle(color: Colors.orange)),
                        // Text(
                        //   'Total minutes of activity: ${totalActivityMinutes} min '
                        //       '(${activitySummary.fairlyActiveMinutes
                        //       .toString()} min light and '
                        //       '${activitySummary.veryActiveMinutes
                        //       .toString()} min very active)'
                        // ),
                        Text('Resting heart rate: ${activitySummary
                            .restingHeartRate} BPM', style: TextStyle(color: Colors.orange)),
                      ],
                    ),
                  );
                }
              },
            ),
            Text(''),
            ElevatedButton(
              onPressed: () => _selectSleepDate(context),
              child: const Text('Sleep date'),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.purpleAccent,
              ),
            ),
            const Text(
              'Sleep data:',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                            sleepSummary.totalTimeInBed)}', style: TextStyle(color: Colors.purple)),
                        Text('Total time asleep: ${_convertMinToHrMin(
                            sleepSummary.totalMinutesAsleep)}', style: TextStyle(color: Colors.purple)),
                        Text('Total time awake: ${_convertMinToHrMin(
                            sleepSummary.stages.wake)}', style: TextStyle(color: Colors.purple)),
                        Text('Total time in light sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.light)}', style: TextStyle(color: Colors.purple)),
                        Text('Total time in deep sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.deep)}', style: TextStyle(color: Colors.purple)),
                        Text('Total time in REM sleep: ${_convertMinToHrMin(
                            sleepSummary.stages.rem)}', style: TextStyle(color: Colors.purple)),
                      ],
                    ),
                  );
                }
              },
            ),
            Text(''),
            ElevatedButton(
              onPressed: () => _selectTempDate(context),
              child: const Text('Temperature date'),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.greenAccent,
              ),
            ),
            const Text(
              'Temperature data:',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                                .toString()}', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  );
                }
              },
            ),
            Text(''),
          ],
        ),
      ),
    );
  }
}
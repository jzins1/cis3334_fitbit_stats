import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

// API authenticated activity, heartrate, sleep, and temperature
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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Fitbit statistics (today):',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )
            ),
            Text('Number of steps: 6942'),
            Text('Total minutes of activity: 67 (46 light and 21 very active)'),
            Text('Resting heart rate: 60 BPM'),
            Text('Total time in bed: 16 hours 24 minutes'),
            Text('Total time asleep: 14 hours 22 minutes'),
            Text('Total time awake: 2 hours 2 minutes'),
            Text('Total time in light sleep: 9 hours 13 minutes'),
            Text('Total time in deep sleep: 1 hour 48 minutes'),
            Text('Total time in REM sleep: 3 hours 21 minutes'),
            Text('Relative skin temperature (from baseline in degrees F): 1.7'),

            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
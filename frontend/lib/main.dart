import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  List<dynamic> _weatherData = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData(); 
  }

  Future<void> _fetchWeatherData() async {
    final url = Uri.parse('http://localhost:5139/weatherforecast');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
       setState(() {
        _weatherData = data.map((item) {
          return {
            'date': item['date'],
            'temperatureC': item['temperatureC'],
            'summary': item['summary'],
            'temperatureF': item['temperatureF'],
          };
        }).toList();
      });
      } 
    } catch (error) {
      setState(() {
        _weatherData = [];
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather Data:',
            ),
            Expanded(
              child: Column(
                      children: _weatherData.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Date: ${item['date']}\n'
                            'Summary: ${item['summary']}\n'
                            'Temp: ${item['temperatureC']}°C (${item['temperatureF']}°F)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          _fetchWeatherData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
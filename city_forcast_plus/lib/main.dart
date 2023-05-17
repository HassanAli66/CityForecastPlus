import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'disaster.dart';
import 'hostAddress.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityForcast+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String cityName = '';
  String temperature = '';
  String weatherType = '';
  String weatherIcon = '';
  String errorMessage = '';

  final TextEditingController _controller = TextEditingController();

  Future<void> _getWeatherData(String city) async {
    try {
      final url =
          '${await getIpAddress(0)}/weather?city=$city'; //the flask microservice
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          cityName = data['name'];
          temperature = '${data['main']['temp']}°C';
          weatherType = data['weather'][0]['description'];
          weatherIcon = data['weather'][0]['icon'];
          errorMessage = '';
        });
      } else {
        setState(() {
          cityName = '';
          temperature = '';
          weatherType = '';
          weatherIcon = '';
          errorMessage = 'Unable to fetch weather data';
        });
      }
    } catch (e) {
      setState(() {
        cityName = '';
        temperature = '';
        weatherType = '';
        weatherIcon = '';
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('CityForcast+'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.warning,
              color: Colors.yellow,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NaturalDisastersPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _getWeatherData(_controller.text);
                },
                child: const Text('Get Weather'),
              ),
              const SizedBox(height: 16),
              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(fontSize: 32)),
              if (cityName.isNotEmpty) ...[
                Text(cityName, style: const TextStyle(fontSize: 32)),
                Text(temperature, style: const TextStyle(fontSize: 64)),
                Image.network(
                  'http://openweathermap.org/img/w/$weatherIcon.png',
                  height: 100,
                  width: 100,
                ),
                Text(weatherType, style: const TextStyle(fontSize: 24)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

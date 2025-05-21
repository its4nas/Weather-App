import 'package:flutter/material.dart';
import 'package:weather_app/widget/weather_data_tile.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WeatherPage());
  }
}


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  String _bgImg = 'assets/images/clear.jpg';
  String _iconImg = 'assets/icons/Clear.png';
  String _cityName = '';
  String _temperature = '';
  String _tempMax = '';
  String _tempMin = '';
  String _main = '';
  String _pressure = '';
  String _humidity = '';
  String _windSpeed = '';
  String _sunrise = '';
  String _sunset = '';
  String _visibility = '';
  
  @override
  void initState() {
    super.initState();
    _getLocationWeather();
  }

  Future<void> _getLocationWeather() async {
    final weatherService = WeatherService();
    final weatherData = await weatherService.fetchWeather();
    
    if (weatherData['success']) {
      final data = weatherData['data'];
      setState(() {
        _cityName = data['name'];
        _temperature = data['main']['temp'].toStringAsFixed(1);
        _tempMax = data['main']['temp_max'].toStringAsFixed(1);
        _tempMin = data['main']['temp_min'].toStringAsFixed(1);
        _main = data['weather'][0]['main'];
        _pressure = data['main']['pressure'].toString();
        _humidity = data['main']['humidity'].toString();
        _windSpeed = data['wind']['speed'].toString();
        _sunrise = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000));
        _sunset = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000));
        _visibility = data['visibility'].toString();
        
        if(_main == 'Clear') {
          _bgImg = 'assets/images/clear.jpg';
          _iconImg = 'assets/icons/Clear.png';
        } else if(_main == 'Clouds') {
          _bgImg = 'assets/images/cloudy.jpg';
          _iconImg = 'assets/icons/Clouds.png';
        } else if(_main == 'Rain') {
          _bgImg = 'assets/images/rainy.jpg';
          _iconImg = 'assets/icons/Rain.png';
        } else if(_main == 'Fog') {
          _bgImg = 'assets/images/fog.jpg';
          _iconImg = 'assets/icons/Haze.png';
        } else if(_main == 'Thunderstorm') {
          _bgImg = 'assets/images/thunderstorm.jpg';
          _iconImg = 'assets/icons/Thunderstorm.png';
        } else{
          _bgImg = 'assets/images/haze.jpg';
          _iconImg = 'assets/icons/Haze.png';
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(weatherData['error']),
            backgroundColor: const Color.fromARGB(61, 124, 150, 184),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }

  getData(String cityName) async {
    final weatherService = WeatherService();
    var weatherData;
    if (cityName == '') {
      weatherData = await weatherService.fetchWeather();
    } else {
      weatherData = await weatherService.getWeather(cityName);
    }
    
    if (weatherData['success']) {
      final data = weatherData['data'];
      setState(() {
        _cityName = data['name'];
        _temperature = data['main']['temp'].toStringAsFixed(1);
        _tempMax = data['main']['temp_max'].toStringAsFixed(1);
        _tempMin = data['main']['temp_min'].toStringAsFixed(1);
        _main = data['weather'][0]['main'];
        _pressure = data['main']['pressure'].toString();
        _humidity = data['main']['humidity'].toString();
        _windSpeed = data['wind']['speed'].toString();
        _sunrise = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000));
        _sunset = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000));
        _visibility = data['visibility'].toString();
        
        if(_main == 'Clear') {
          _bgImg = 'assets/images/clear.jpg';
          _iconImg = 'assets/icons/Clear.png';
        } else if(_main == 'Clouds') {
          _bgImg = 'assets/images/cloudy.jpg';
          _iconImg = 'assets/icons/Clouds.png';
        } else if(_main == 'Rain') {
          _bgImg = 'assets/images/rainy.jpg';
          _iconImg = 'assets/icons/Rain.png';
        } else if(_main == 'Fog') {
          _bgImg = 'assets/images/fog.jpg';
          _iconImg = 'assets/icons/Haze.png';
        } else if(_main == 'Thunderstorm') {
          _bgImg = 'assets/images/thunderstorm.jpg';
          _iconImg = 'assets/icons/Thunderstorm.png';
        } else{
          _bgImg = 'assets/images/haze.jpg';
          _iconImg = 'assets/icons/Haze.png';
        }
      });
    } else {
      // Show error message using SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(weatherData['error']),
            backgroundColor: const Color.fromARGB(61, 124, 150, 184),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      getData('');
    }
    getData('');
    return true;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/haze.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            ),
            Padding(padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        getData(value);
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            getData(_controller.text);
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.black26,   
                      hintText: 'Search for a city',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 10),
                      Text(_cityName, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_temperature, style: TextStyle(color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(_main, style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                      Image.asset(_iconImg, width: 90, height: 90,),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_upward, color: Colors.black,),
                      Text(_tempMax, style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),),
                      const Icon(Icons.arrow_downward, color: Colors.black,),
                      Text(_tempMin, style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Card(
                    elevation: 5,
                    color: const Color.fromARGB(74, 61, 66, 94),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      // color: Colors.transparent,
                      child: Column(
                        children: [
                          WeatherDataTile(index1: 'Sunrise', index2: 'Sunset', value1: _sunrise, value2: _sunset),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),    
                          WeatherDataTile(index1: 'Humidity', index2: 'Visibility', value1: _humidity, value2: _visibility),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          WeatherDataTile(index1: 'Precipitation', index2: 'Wind Speed', value1: _pressure, value2: _windSpeed),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

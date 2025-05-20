import 'package:flutter/material.dart';
import 'package:weather_app/widget/weather_data_tile.dart';

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
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
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
                        Text('Jakarta', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('19.5°C', style: TextStyle(color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Haze', style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                        Image.asset('assets/icons/Haze.png', width: 90, height: 90,),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.black,),
                        Text('19.5°C', style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),),
                        const Icon(Icons.arrow_downward, color: Colors.black,),
                        Text('19.5°C', style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),),
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
                            WeatherDataTile(index1: 'Sunrise', index2: 'Sunset', value1: '06:00', value2: '18:00'),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),    
                            WeatherDataTile(index1: 'Humidity', index2: 'Visibility', value1: '60%', value2: '10000'),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            WeatherDataTile(index1: 'Precipitation', index2: 'Wind Speed', value1: '6', value2: '45'),
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

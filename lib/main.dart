import 'package:flutter/material.dart';

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
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Jakarta', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 80),
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

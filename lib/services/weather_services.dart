import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'fe8e477b4e99a6a0435d23f0cd32d943';

  Future<Map<String, dynamic>> getWeather(String cityName) async 
  {
    try {
      final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body)
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'error': errorData['message'] ?? 'Failed to load weather data'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Unable to connect to weather service. Please check your internet connection.'
      };
    }
  }


  Future<Map<String, dynamic>> fetchWeather() async 
  {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return {
            'success': false,
            'error': 'Location permission denied. Please enable location services.'
          };
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return {
          'success': false,
          'error': 'Location permission permanently denied. Please enable location in settings.'
        };
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return {
          'success': false,
          'error': 'Location services are disabled. Please enable location services.'
        };
      }

      print('Fetching weather for current location');
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude, lon = position.longitude;
      
      final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body)
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'error': errorData['message'] ?? 'Failed to load weather data'
        };
      }
    } catch (e) {
      if (e is TimeoutException) {
        return {
          'success': false,
          'error': 'Connection timed out. Please check your internet connection.'
        };
      }
      return {
        'success': false,
        'error': 'Unable to connect to weather service. Please check your internet connection and location services.'
      };
    }
  }
}

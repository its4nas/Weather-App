import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'fe8e477b4e99a6a0435d23f0cd32d943';

  Future<Map<String, dynamic>> getWeather(String cityName) async 
  {
    try {
      print('Fetching weather for city: $cityName');
      final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
      print('Request URL: $url');
      
      final response = await http.get(url);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
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
    } catch (e, stackTrace) {
      print('Error details: $e');
      print('Stack trace: $stackTrace');
      return {
        'success': false,
        'error': 'Unable to connect to weather service. Please check your internet connection.'
      };
    }
  }


  Future<Map<String, dynamic>> fetchWeather(String cityName) async 
  {
    try {
      print('Fetching weather for current location');
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude, lon = position.longitude;
      print('Location: lat=$lat, lon=$lon');
      
      final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
      print('Request URL: $url');
      
      final response = await http.get(url);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
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
    } catch (e, stackTrace) {
      print('Error details: $e');
      print('Stack trace: $stackTrace');
      return {
        'success': false,
        'error': 'Unable to connect to weather service. Please check your internet connection.'
      };
    }
  }
}

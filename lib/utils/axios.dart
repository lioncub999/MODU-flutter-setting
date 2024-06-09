import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String apiUrl = dotenv.env['API_URL'] ?? 'http:/localhost:8080';

  // GET 요청
  static Future<http.Response> getRequest(String url, {String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwtToken');

    final uri = Uri.parse(apiUrl+url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // POST 요청
  static Future<http.Response> postRequest(
      String url, Map<String, dynamic> data,
      {String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwtToken');

    final uri = Uri.parse(apiUrl+url);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
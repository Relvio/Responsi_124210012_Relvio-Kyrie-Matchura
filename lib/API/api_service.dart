import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_124210012/API/api_model_categories.dart';
import 'package:responsi_124210012/API/api_model_lookup.dart';

class ApiService {
  static const String CategoryApiUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
  static const String FilterApiUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood';
  static const String LookupApiUrl =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772';

  static Future<List<Categories>> fetchArticles() async {
    final response = await http.get(Uri.parse(CategoryApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  static Future<List<Meals>> fetchBlogs() async {
    final response = await http.get(Uri.parse(FilterApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Meals.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  static Future<List<Meals>> fetchReports() async {
    final response = await http.get(Uri.parse(LookupApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Meals.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reports');
    }
  }
}

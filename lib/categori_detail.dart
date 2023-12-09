import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi_124210012/API/api_model_categories.dart';

class CategoryDetailPage extends StatefulWidget {
  final String? strCategory;

  CategoryDetailPage({required this.strCategory});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late Future<Map<String, dynamic>> CategoryDetails;

  @override
  void initState() {
    super.initState();
    CategoryDetails = fetchCategoryDetails(widget.strCategory);
  }

  Future<Map<String, dynamic>> fetchCategoryDetails(String? strCategory) async {
    final response = await http.get(Uri.parse(
        'https://api.spaceflightnewsapi.net/v4/articles/ $strCategory'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categori details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CATEGORIES DETAIL'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: CategoryDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Extract details from the snapshot.data
            Categories kategori = Categories.fromJson(snapshot.data!);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text('Title: ${kategori.strCategory ?? 'N/A'}')),
                    if (kategori.strCategoryThumb != null)
                      Image.network(
                        kategori.strCategoryThumb!,
                        height: 600, // Set the desired height
                        width: 600, // Set the desired width
                      ),
                    Text(' ${kategori.strCategory ?? 'N/A'}'),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

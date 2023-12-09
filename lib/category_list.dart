import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi_124210012/API/api_model_categories.dart';
import 'package:responsi_124210012/categori_detail.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Categories>> kategori;

  @override
  void initState() {
    super.initState();
    kategori = fetchCategories();
  }

  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['categories'];
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CATEGORIES LIST'),
      ),
      body: FutureBuilder<List<Categories>>(
        future: kategori,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Categories kategori = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: kategori.strCategoryThumb != null
                              ? Image.network(
                                  kategori.strCategoryThumb!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Spacer(),
                        ),
                        SizedBox(height: 8.0),
                        Center(
                          child: ListTile(
                            title: Text(kategori.strCategory!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailPage(
                                    strCategory: kategori.strCategory,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                                'Description: ${kategori.strCategoryDescription ?? 'N/A'}'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

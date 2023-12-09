import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi_124210012/API/api_model_lookup.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  late Future<List<Meals>> filter;

  @override
  void initState() {
    super.initState();
    filter = fetchFilter();
  }

  Future<List<Meals>> fetchFilter() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Meals'];
      return data.map((json) => Meals.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load filter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FILTER LIST'),
      ),
      body: FutureBuilder<List<Meals>>(
        future: filter,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Meals filter = snapshot.data![index];
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
                      SizedBox(height: 8.0),
                      ListTile(
                        title: Text(filter.strMeal!),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
              },
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

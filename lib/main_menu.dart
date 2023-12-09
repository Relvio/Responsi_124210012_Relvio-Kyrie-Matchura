import 'package:flutter/material.dart';
import 'package:responsi_124210012/category_list.dart';
import 'package:responsi_124210012/filter_list.dart';
import 'package:responsi_124210012/lookup_list.dart';

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('MENU UTAMA')),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuItem(
                imagePath: 'assets/categori.jpg',
                label: 'Categories',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryList()),
                  );
                },
              ),
              MenuItem(
                imagePath: 'assets/filter.jpg',
                label: 'Filter',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterList()),
                  );
                },
              ),
              MenuItem(
                imagePath: 'assets/lookup.jpg',
                label: 'Look Up',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LookUpList()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

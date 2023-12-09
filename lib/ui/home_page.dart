import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_mobile/ui/meals_page.dart';

import '../models/categories_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<List<CategoryModel>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
  if (response.statusCode == 200) {
    List<CategoryModel> categories = (json.decode(response.body)['categories'] as List)
        .map((data) => CategoryModel.fromJson(data))
        .toList();
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}
class _HomePageState extends State<HomePage> {
  late Future<List<CategoryModel>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Meal Categories",
            style: TextStyle(
                color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.map((category) {
                return Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MealsPage(category: category.strCategory)
                            )
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(category.strCategoryThumb),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    category.strCategory,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Text(category.strCategoryDescription),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
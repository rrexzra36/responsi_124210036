import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/details_model.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<DetailMeal>> _meals;

  @override
  void initState() {
    super.initState();
    _meals = fetchMeals();
  }

  Future<List<DetailMeal>> fetchMeals() async {
    final response = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.id}"));
    if (response.statusCode == 200) {
      List<DetailMeal> meals = (json.decode(response.body)['meals'] as List)
          .map((data) => DetailMeal.fromJson(data))
          .toList();
      return meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Detail"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DetailMeal>>(
        future: _meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No meals found.'),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data![0].strMealThumb),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Center(
                        child: Text(
                          "${snapshot.data![0].strMeal}",
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Category : ${snapshot.data![0].strCategory}"),
                      Text("Area : ${snapshot.data![0].strArea}"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Center(
                        child: Text(
                          "Ingredients",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(snapshot.data![0].strIngredient1!=null && snapshot.data![0].strIngredient1!="") (
                          Text("${snapshot.data![0].strIngredient1}")
                      ),
                      if(snapshot.data![0].strIngredient2!=null && snapshot.data![0].strIngredient2!="") (
                          Text("${snapshot.data![0].strIngredient2}")
                      ),
                      if(snapshot.data![0].strIngredient3!=null && snapshot.data![0].strIngredient3!="") (
                          Text("${snapshot.data![0].strIngredient3}")
                      ),
                      if(snapshot.data![0].strIngredient4!=null && snapshot.data![0].strIngredient4!="") (
                          Text("${snapshot.data![0].strIngredient4}")
                      ),
                      if(snapshot.data![0].strIngredient5!=null && snapshot.data![0].strIngredient5!="") (
                          Text("${snapshot.data![0].strIngredient5}")
                      ),
                      if(snapshot.data![0].strIngredient6!=null && snapshot.data![0].strIngredient6!="") (
                          Text("${snapshot.data![0].strIngredient6}")
                      ),
                      if(snapshot.data![0].strIngredient7!=null && snapshot.data![0].strIngredient7!="") (
                          Text("${snapshot.data![0].strIngredient7}")
                      ),
                      if(snapshot.data![0].strIngredient8!=null && snapshot.data![0].strIngredient8!="") (
                          Text("${snapshot.data![0].strIngredient8}")
                      ),
                      if(snapshot.data![0].strIngredient9!=null && snapshot.data![0].strIngredient9!="") (
                          Text("${snapshot.data![0].strIngredient9}")
                      ),
                      if(snapshot.data![0].strIngredient10!=null && snapshot.data![0].strIngredient10!="") (
                          Text("${snapshot.data![0].strIngredient10}")
                      ),
                      if(snapshot.data![0].strIngredient11!=null && snapshot.data![0].strIngredient11!="") (
                          Text("${snapshot.data![0].strIngredient11}")
                      ),
                      if(snapshot.data![0].strIngredient12!=null && snapshot.data![0].strIngredient12!="") (
                          Text("${snapshot.data![0].strIngredient12}")
                      ),
                      if(snapshot.data![0].strIngredient13!=null && snapshot.data![0].strIngredient13!="") (
                          Text("${snapshot.data![0].strIngredient13}")
                      ),
                      if(snapshot.data![0].strIngredient14!=null && snapshot.data![0].strIngredient14!="") (
                          Text("${snapshot.data![0].strIngredient14}")
                      ),
                      if(snapshot.data![0].strIngredient15!=null && snapshot.data![0].strIngredient15!="") (
                          Text("${snapshot.data![0].strIngredient15}")
                      ),
                      if(snapshot.data![0].strIngredient16!=null && snapshot.data![0].strIngredient16!="") (
                          Text("${snapshot.data![0].strIngredient16}")
                      ),
                      if(snapshot.data![0].strIngredient17!=null && snapshot.data![0].strIngredient17!="") (
                          Text("${snapshot.data![0].strIngredient17}")
                      ),
                      if(snapshot.data![0].strIngredient18!=null && snapshot.data![0].strIngredient18!="") (
                          Text("${snapshot.data![0].strIngredient18}")
                      ),
                      if(snapshot.data![0].strIngredient19!=null && snapshot.data![0].strIngredient19!="") (
                          Text("${snapshot.data![0].strIngredient19}")
                      ),
                      if(snapshot.data![0].strIngredient20!=null && snapshot.data![0].strIngredient20!="") (
                          Text("${snapshot.data![0].strIngredient20}")
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Center(
                        child: Text(
                          "Instructions",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("${snapshot.data![0].strInstructions}"),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        _launcher("${snapshot.data![0].strYoutube}");
                        print("tes");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          Text(
                            "Watch Tutorial",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void> _launcher(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception("Gagal membuka url : $_url");
    }
  }
}

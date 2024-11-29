import 'dart:convert';

import 'package:project/helpers/apis.dart';
import 'package:project/helpers/http_client.dart';
import 'package:project/models/food.dart';

class _FoodService {
  Future<List<Food>> getFoods() async {
    var response = await client.get(Uri.parse(Apis.foods));
    if(response.statusCode == 200) {
      List<dynamic> foods = jsonDecode(response.body);
      return foods.map((food) => Food.fromJson(food)).toList();
    }
    return [];
  }

  Future<List<Food>> getFoodsByCategory(String category) async {
    var response = await client.get(Uri.parse('${Apis.foods}/category/$category'));
    if(response.statusCode == 200) {
      List<dynamic> foods = jsonDecode(response.body);
      return foods.map((food) => Food.fromJson(food)).toList();
    }
    return [];
  }

  Future<Food?> getFoodById(String id) async {
    var response = await client.get(Uri.parse('${Apis.foods}/$id'));
    if(response.statusCode == 200) {
      return Food.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<void> toggleFavourite(String id, bool isToggled) async {
    if(isToggled){
      final response = await client.delete(Uri.parse('${Apis.favoriteFoods}/food/$id'));
      if(response.statusCode == 200) {
        return;
      }
      throw Exception('Failed to toggle favourite');
    }else{
      final response = await client.post(Uri.parse(Apis.favoriteFoods), body: {
        "food": id
      });
      if(response.statusCode == 201) {
        return;
      }
      throw Exception('Failed to toggle favourite');
    }
  }
}

final foodService = _FoodService();
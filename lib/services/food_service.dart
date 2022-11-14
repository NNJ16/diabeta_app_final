import 'dart:convert';

import 'package:diabeta_app/model/food_cal.dart';
import 'package:dio/dio.dart';

class FoodCalcService{
  static const String _API_KEY = "Wx2KqReXHfyEC7Hjdm75xA==lpGlJRy5dO6W8EoT";
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<List<FoodCal>> getFoodNutritions(String query) async{
    String api_url = 'https://api.calorieninjas.com/v1/nutrition?query=';
    List<FoodCal> foodList = [];
    try {
      var response = await Dio().get(api_url + query,
        options: Options(
            headers: {
              "X-Api-Key": _API_KEY,
            },
          ),
      );
      var items = response.data['items'];
  
      for(var item in items){
        FoodCal foodCal = FoodCal(
          name: item['name'],
          serveSize: item['serving_size_g'],
          calorie: item['calories'],
          totFat: item['fat_total_g'],
          satFat: item['fat_saturated_g'],
          sodium: item['sodium_mg'],
          carbs: item['carbohydrates_total_g'],
          fiber: item['fiber_g'],
          protein: item['protein_g'],
          sugar: item['sugar_g']
        );
        foodList.add(foodCal);
      } 
    } catch (e) {
      print(e);
    }
    return foodList;
  }

  static Future<String> getFoodRecommendationList(String clean_input) async{
    var data = {
      "clean_input": clean_input
    };

    var response = await Dio().post(api_url + "/food/recommendation",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
}
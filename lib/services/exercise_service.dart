import 'dart:convert';
import 'package:diabeta_app/model/exercise.dart';
import 'package:diabeta_app/model/exercise_cal.dart';
import 'package:dio/dio.dart';

class ExerciseService {
  static const String _APP_ID = "01e29302";
  static const String _API_KEY = "0a2220fadb63fd55438ec22af43f3767";
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<List<ExerciseCal>> getExerciseDetails(String query) async {
    String api_url = 'https://trackapi.nutritionix.com/v2/natural/exercise';
    List<ExerciseCal> exerciseList = [];
    try {
      var data = {
        "query": query,
        "gender": "female",
        "weight_kg": 72.5,
        "height_cm": 167.64,
        "age": 30
      };
      var response = await Dio().post(api_url,
          options: Options(
            headers: {
              "x-app-id": _APP_ID,
              "x-app-key": _API_KEY,
              "Content-Type": "application/json"
            },
          ),
          data: jsonEncode(data));

      var items = response.data["exercises"];
      print(items);

      for (var item in items) {
        ExerciseCal exerciseCal = ExerciseCal(
            exercise: item["user_input"],
            calories: item["nf_calories"],
            duration: item["duration_min"],
            met: item["met"]);

        exerciseList.add(exerciseCal);
      }
    } catch (e) {
      print(e);
    }
    return exerciseList;
  }

  static Future<String> getExerciseRecommendationList(Exercise exercise) async {
    String prediabetes="", diabetes="";
    
    if(exercise.diabetes == "Prediabetes"){
      prediabetes = "prediabetic";
    }else if(exercise.diabetes == "Diabetes"){
      prediabetes = "prediabetic";
      diabetes = "diabetic";
    }else if(exercise.diabetes == "None"){
      prediabetes = "nonprediabetic";
      diabetes = "nondiabetic";
    }

    print(exercise.lifestyle.toLowerCase());
    print(exercise.category.toLowerCase());
    print(exercise.activity.toLowerCase());
    print(prediabetes);
    print(diabetes);

    var data = {
      "Lifestyle": exercise.lifestyle.toLowerCase(),
      "Category": exercise.category.toLowerCase(),
      "Activity-level": exercise.activity.toLowerCase(),
      "PreDiabetic": prediabetes,
      "Diabetic": diabetes
    };

    var response = await Dio().post(api_url + "/exercise/recommendation",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
        print(response.data);
    return response.data;
  }
}

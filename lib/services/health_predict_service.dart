import 'dart:convert';
import 'package:diabeta_app/model/diabetes_ques_ans.dart';
import 'package:diabeta_app/model/health_ques_ans.dart';
import 'package:dio/dio.dart';

class HealthPredictService {
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<String> getHeartPrediction() async {
    var data = {
      "Age": HealthQuestions.heartQuiz[0].defaultValue,
      "Gender": HealthQuestions.heartQuiz[1].defaultValue,
      "Blood Pressure": HealthQuestions.heartQuiz[2].defaultValue,
      "Cholesterol": HealthQuestions.heartQuiz[3].defaultValue,
      "Stress Level": HealthQuestions.heartQuiz[4].defaultValue,
      "Smoking Status": HealthQuestions.heartQuiz[5].defaultValue,
      "Activitve Level": HealthQuestions.heartQuiz[6].defaultValue,
      "Diabetes Status": HealthQuestions.heartQuiz[7].defaultValue
    };

    var response = await Dio().post(api_url + "/heartrisk/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    print(response.data);
    return response.data;
  }

  static Future<String> getEyePrediction() async {
    var data = {
      "Age": HealthQuestions.eyeQuiz[0].defaultValue,
      "Gender": HealthQuestions.eyeQuiz[1].defaultValue,
      "Glucoma": HealthQuestions.eyeQuiz[2].defaultValue,
      "Surgery": HealthQuestions.eyeQuiz[3].defaultValue,
      "Pain": HealthQuestions.eyeQuiz[4].defaultValue,
      "Vision": HealthQuestions.eyeQuiz[5].defaultValue,
      "Diabetes": HealthQuestions.eyeQuiz[6].defaultValue
    };

    var response = await Dio().post(api_url + "/eyerisk/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }

  static Future<String> getKidneyPrediction() async {
    var data = {
      "Age": HealthQuestions.kidneyQuiz[0].defaultValue,
      "Gender": HealthQuestions.kidneyQuiz[1].defaultValue,
      "Take Medicine": HealthQuestions.kidneyQuiz[4].defaultValue,
      "Kidney Problem": HealthQuestions.kidneyQuiz[5].defaultValue,
      "Urine Low": HealthQuestions.kidneyQuiz[6].defaultValue,
      "Diabetes": HealthQuestions.kidneyQuiz[7].defaultValue
    };

    var response = await Dio().post(api_url + "/kidneyrisk/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
}

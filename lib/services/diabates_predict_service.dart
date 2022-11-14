import 'dart:convert';
import 'package:diabeta_app/model/diabetes_ques_ans.dart';
import 'package:diabeta_app/model/glucose_data.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DiabatesPredictService {
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<String> getPrediabatesPrediction() async {
    var data = {
      "Age": DiabeticQuestions.sampleQuiz2[0].defaultValue,
      "Gender": DiabeticQuestions.sampleQuiz2[1].defaultValue,
      "Polyuria": DiabeticQuestions.sampleQuiz2[2].defaultValue,
      "Polydipsia": DiabeticQuestions.sampleQuiz2[3].defaultValue,
      "SuddenWeightLoss": DiabeticQuestions.sampleQuiz2[5].defaultValue,
      "Irritability": DiabeticQuestions.sampleQuiz2[6].defaultValue,
      "DelayedHealing": DiabeticQuestions.sampleQuiz2[7].defaultValue,
      "PartialParesis": DiabeticQuestions.sampleQuiz2[4].defaultValue,
      "Alopecia": DiabeticQuestions.sampleQuiz2[8].defaultValue,
      "VisualBlurring": DiabeticQuestions.sampleQuiz2[9].defaultValue
    };

    var response = await Dio().post(api_url + "/prediabetes/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }

  static Future<String> getFuturGlucoseLevel(
      DateTime dateTime, List glucose) async {
    var response = await Dio().post(api_url + "/glucose/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: {
          "fromDate": DateFormat('MM/d/yyyy').format(dateTime).toString(),
          "glucose": glucose,
        });
    return response.data;
  }

  static Future<String> getDiabatesPrediction() async {
    double weight = DiabeticQuestions.sampleQuiz1[3].defaultValue;
    double hieght = DiabeticQuestions.sampleQuiz1[2].defaultValue / 100.0;

    double bmi = weight / (hieght * hieght);

    var data = {
      "Age": DiabeticQuestions.sampleQuiz1[1].defaultValue,
      "Glucose": DiabeticQuestions.sampleQuiz1[4].defaultValue,
      "BloodPressure": DiabeticQuestions.sampleQuiz1[5].defaultValue,
      "Insulin": DiabeticQuestions.sampleQuiz1[6].defaultValue,
      "SkinThickness": DiabeticQuestions.sampleQuiz1[7].defaultValue,
      "BMI": bmi
    };

    var response = await Dio().post(api_url + "/diabetes/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
}

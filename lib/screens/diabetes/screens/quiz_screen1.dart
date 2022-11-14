import 'dart:convert';
import 'package:diabeta_app/components/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/screens/diabetes/components/q_card1.dart';
import 'package:diabeta_app/screens/diabetes/screens/print_screen1.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../model/diabetes_ques_ans.dart';
import '../../../services/diabates_predict_service.dart';

class QuizScreen1 extends StatefulWidget {
  const QuizScreen1({Key? key}) : super(key: key);

  @override
  State<QuizScreen1> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen1> {
  bool isLoading = false;
  bool isResult = false;
  bool isPositive = false;
  double riskScore = 0;

  String positiveMsg =
      "Based on your score, you are likely to have prediabetes. Seeing your doctor is the critical next step to determining if you have prediabetes.";
  String negativeMsg =
      "Based on your risk score, your prediabetes risk is low, continue having a healty life style.";

  void setResult() async {
    setState(() {
      isLoading = true;
    });
    String result = await DiabatesPredictService.getPrediabatesPrediction();

    setState(() {
      riskScore = jsonDecode(result)['probability'] * 100;
      if (jsonDecode(result)['result'] == 0) {
        isPositive = false;
      } else {
        isPositive = true;
      }
      isResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text("Prediabates Prediction"),
        backgroundColor: kPrimaryColor,
      ),
      body: !isLoading
          ? Container(
              height: 500,
              child: Swiper(
                loop: false,
                itemCount: DiabeticQuestions.sampleQuiz2.length,
                itemHeight: 400.0,
                itemWidth: 600,
                onIndexChanged: (index) {},
                layout: SwiperLayout.STACK,
                pagination: const SwiperPagination(),
                itemBuilder: (BuildContext context, int index) {
                  return QCard1(
                      ques: DiabeticQuestions.sampleQuiz2[index],
                      callBack: setResult);
                },
              ),
            )
          : !isResult
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingFlipping.circle(
                      borderColor: kPrimaryColor,
                      // borderSize: 3.0,
                      size: 60.0,
                      backgroundColor: kPrimaryColor,
                      duration: const Duration(milliseconds: 2000),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Loading result...')
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 400,
                    width: 600,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/diabetsresult.png",
                          width: 200,
                          height: 180,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 16.0, left: 24),
                          child: Row(
                            children: [
                              const Text(
                                "Your Risk Score : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              riskScore <= 50
                                  ? Text(
                                      riskScore.toString() + "%",
                                      style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      riskScore.toString() + "%",
                                      style: TextStyle(
                                          color: Colors.red[400],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                            ],
                          ),
                        ),
                        isPositive
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                child: Text(positiveMsg),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                child: Text(negativeMsg),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrintScreen1(
                                        prediction: isPositive,
                                        riskScore: riskScore,
                                        comment: isPositive
                                            ? positiveMsg
                                            : negativeMsg,
                                      )),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 24.0, right: 24.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16.0),
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: const BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    )),
                                child: const Center(
                                  child: Text(
                                    'DOWNLOAD',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

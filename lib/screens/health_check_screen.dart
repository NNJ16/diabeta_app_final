import 'package:diabeta_app/components/category_card.dart';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/diabetes/screens/quiz_screen.dart';
import 'package:diabeta_app/screens/health/eye_risk_screen.dart';
import 'package:diabeta_app/screens/health/heart_risk_screen.dart';
import 'package:diabeta_app/screens/health/kidney_risk_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'diabetes/screens/quiz_screen1.dart';

class HealthCheckScreen extends StatefulWidget {
  const HealthCheckScreen({Key? key}) : super(key: key);

  @override
  State<HealthCheckScreen> createState() => _HealthCheckScreenState();
}

class _HealthCheckScreenState extends State<HealthCheckScreen> {
  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          InkWell(
            child: const CategoryCard(
              title: "Diabetes Risk",
              imgPath: "assets/images/diabetes.jpeg",
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Could you have prediabetes?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const QuizScreen1()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              const Text(
                                'Could you have type 2 diabetes?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const QuizScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
              // showDialog(
              //   context: context,
              //   builder: (BuildContext buildContext) => (DiabetesTestType(
              //       buildContext: context,)),
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const QuizScreen()),
              // );
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Heart Risk",
              imgPath: "assets/images/heart.jpeg",
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Could you have a heart risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HeartRiskScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              const Text(
                                'What is a heart risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(
                                      "https://diabeta.000webhostapp.com/heartedu.html");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'LEARN MORE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Eye Risk",
              imgPath: "assets/images/eye.jpeg",
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Could you have a eye risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EyeRiskScreen()),
              );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              const Text(
                                'What is a eye risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(
                                      "https://diabeta.000webhostapp.com/eyeedu.html");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'LEARN MORE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Kidney Risk",
              imgPath: "assets/images/kidney.jpeg",
            ),
            onTap: () {
 showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Could you have a kidney risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KidneyRiskScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              const Text(
                                'What is a kidney risk?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(
                                      "https://diabeta.000webhostapp.com/kidneyedu.html");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'LEARN MORE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            },
          ),
        ],
      ),
    );
  }
}

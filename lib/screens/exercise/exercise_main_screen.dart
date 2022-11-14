import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/exercise/exercise_calculator_screen.dart';
import 'package:diabeta_app/screens/exercise/exercise_recommendation_screen.dart';
import 'package:flutter/material.dart';

class ExerciseMainScreen extends StatefulWidget {
  const ExerciseMainScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseMainScreen> createState() => _ExerciseMainScreenState();
}

class _ExerciseMainScreenState extends State<ExerciseMainScreen> {
  int selectedIndex =0;

  void setSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  setSelectedIndex(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: const Border(
                    //     top: BorderSide(width: 1, color: Colors.white),
                    //     right: BorderSide(width: 1, color: Colors.white)),
                    color: selectedIndex == 0 ? Colors.teal[300] : kPrimaryColor,
                  ),
                  height: 50,
                  child: const Center(
                      child: Text(
                    'Calculator',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  setSelectedIndex(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: const Border(
                    //     top: BorderSide(width: 1, color: Colors.white)),
                    color: selectedIndex == 1 ? Colors.teal[300] : kPrimaryColor,
                  ),
                  height: 50,
                  child: const Center(
                      child: Text('Recommendations',
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
        selectedIndex == 0 ?
        const ExersiceCalculatorScreen():
        const ExerciseRecommendationScreen()
      ],
    );
  }
}

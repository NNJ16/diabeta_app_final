import 'package:flutter/material.dart';
import '../../../model/exercise_cal.dart';

class ExerciseCalCard extends StatelessWidget {
  final ExerciseCal exerciseCal;
  const ExerciseCalCard({Key? key, required this.exerciseCal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.teal[100],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Exercise", style: TextStyle(fontWeight: FontWeight.bold,),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(exerciseCal.exercise, style: TextStyle(fontSize: 16),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("MET", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(exerciseCal.met.toString(), style: TextStyle(fontSize: 16),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Duration", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(exerciseCal.duration.toString(), style: TextStyle(fontSize: 16),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Est. Calories Burned", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 10,
                        ),
                        Text(exerciseCal.calories.toString(), style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

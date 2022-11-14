import 'dart:convert';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/exercise.dart';
import 'package:diabeta_app/services/exercise_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ExerciseRecommendationScreen extends StatefulWidget {
  const ExerciseRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseRecommendationScreen> createState() =>
      _ExerciseRecommendationScreenState();
}

class _ExerciseRecommendationScreenState
    extends State<ExerciseRecommendationScreen> {
  final GlobalKey<FormFieldState> _key = GlobalKey();

  final List<String> diabetesList = [
    'Prediabetes',
    'Diabetes',
  ];

  bool isLoading = false;

  final List<String> lifeStyleList = ['Yoga', 'Gym'];

  final List<String> activityList = [
    'Sedentary',
    'Light Exercise',
    'Moderate Exercise',
    'Very Active',
  ];

  List<String> categoryList = [];

  final List<String> categoryList1 = [
    'Cardio',
    'Legs+Abs',
    'Upper',
    'Stretching	'
  ];

  final List<String> categoryList2 = [
    'Cardio',
    'Yoga_Poses',
    'Meditation',
    'Stretching	'
  ];
    
  reset() {
    _key.currentState!.reset();
  }


  String lifestyle = "", activity = "", category = "", diabetes = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Life Style :"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    '',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: lifeStyleList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select life style.';
                    }
                  },
                  onChanged: (value) {
                    reset();
                    //Do something when changing the item if you want.
                    if (value == "Gym") {
                      setState(() {
                        categoryList = categoryList1;
                      });
                    } else {
                      setState(() {
                        categoryList = categoryList2;
                      });
                    }
                  },
                  onSaved: (value) {
                    lifestyle = value.toString();
                  },
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Category :"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField2(
                  key: _key,
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    '',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: categoryList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select category.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    category = value.toString();
                  },
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Activity Level :"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    '',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: activityList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select activity level.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    activity = value.toString().replaceAll(' ', '');
                  },
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Diabetes Type :"),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    '',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: diabetesList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select diabetes type.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    diabetes = value.toString();
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                !isLoading
                    ? InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            setState(() {
                              isLoading = true;
                            });
                            Exercise exercise = Exercise(
                                lifestyle: lifestyle,
                                activity: activity,
                                category: category,
                                diabetes: diabetes);
                            var list = await ExerciseService
                                .getExerciseRecommendationList(exercise);

                            if (list == "") {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Exercises not found."),
                                duration: Duration(milliseconds: 2000),
                              ));
                            } else {
                              if (jsonDecode(list).length > 0) {
                                setState(() {
                                  isLoading = false;
                                });
                                showBottomSheet(jsonDecode(list));
                              }
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kPrimaryColor,
                          ),
                          height: 45,
                          width: double.infinity,
                          child: const Center(
                              child: Text(
                            "GENERATE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.teal[200],
                        ),
                        height: 45,
                        width: double.infinity,
                        child: const Center(
                            child: Text(
                          "GENERATING...",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(var exercises) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        )),
                    height: 50,
                    width: double.infinity,
                    child: const Center(
                        child: Text(
                      "Exercises",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("1. " + exercises[0].toString().split("?")[0]),Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text(exercises[0].toString().split("?")[1]),
                            )],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("2. " + exercises[1].toString().split("?")[0]),Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text(exercises[1].toString().split("?")[1]),
                            )],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("3. " + exercises[2].toString().split("?")[0]),Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text(exercises[2].toString().split("?")[1]),
                            )],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("4. " + exercises[3].toString().split("?")[0]),Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text(exercises[3].toString().split("?")[1]),
                            )],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("5. " + exercises[4].toString().split("?")[0]),Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Text(exercises[4].toString().split("?")[1]),
                            )],
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text("6. " + exercises[5].toString().split("?")[0]),Padding(
                      //         padding: const EdgeInsets.only(right:8.0),
                      //         child: Text(exercises[5].toString().split("?")[1]),
                      //       )],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text("7. " + exercises[6].toString().split("?")[0]),Padding(
                      //         padding: const EdgeInsets.only(right:8.0),
                      //         child: Text(exercises[6].toString().split("?")[1]),
                      //       )],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text("8. " + exercises[7].toString().split("?")[0]),Padding(
                      //         padding: const EdgeInsets.only(right:8.0),
                      //         child: Text(exercises[7].toString().split("?")[1]),
                      //       )],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text("9. " + exercises[8].toString().split("?")[0]),Padding(
                      //         padding: const EdgeInsets.only(right:8.0),
                      //         child: Text(exercises[8].toString().split("?")[1]),
                      //       )],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text("10. " + exercises[9].toString().split("?")[0]),Padding(
                      //         padding: const EdgeInsets.only(right:8.0),
                      //         child: Text(exercises[9].toString().split("?")[1]),
                      //       )],
                      //     ),
                      //   ),
                      // ),
                      // const Divider(),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

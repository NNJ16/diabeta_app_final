import 'dart:convert';

import 'package:diabeta_app/services/food_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../components/constants.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<FoodRecommendationScreen> createState() =>
      _FoodRecommendationScreenState();
}

class _FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
  bool isLoading = false;
  final GlobalKey<FormFieldState> _key = GlobalKey();

  final List<String> foodCategory = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Deserts"
  ];

  final List<String> breakfastList=[
    "Rice and Others",
    "Cereals",
    "Dairy Products",
    "Fruits",
    "Vegetables",
    "Seafood",
    "Meat",
  ];

  final List<String> lunchList=[
    "Rice and Others",
    "Dairy Products",
    "Fruits",
    "Vegetables",
    "Seafood",
    "Meat",
  ];
    
  final List<String> dinnerList=[
    "Rice and Others",
    "Fruits",
    "Vegetables",
    "Seafood",
    "Meat",
  ];
  

  final List<String> dessertList=[
    "Fruits",
    "Dairy Products",
    "Beverage"
  ];

  List<String> foodTypeList = [""];

  final List<String> vegNonVegList = [
    "Veg",
    "Non Veg"
  ];

  final List<String> diabetesTypeList = [
    "PreDiabetes",
    "Diabetes"
  ];
  
  reset() {
    _key.currentState!.reset();
  }

  String foodType = "", vegNonVeg = "", diabetesType = "", foodcategory = "";

  final _formKey = GlobalKey<FormState>();

  bool isBreakfastChecked = false;
  bool isLunchChecked = false;
  bool isDinnerChecked = false;
  bool isSnackChecked = false;
  bool isDessertChecked = false;

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
                  child: Text("Select Food Category :"),
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
                  items: foodCategory
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
                      return 'Please select food category.';
                    }
                  },
                  onChanged: (value) {
                    reset();
                    if (value == "Breakfast") {
                      setState(() {
                        foodTypeList = breakfastList;
                      });
                    } else if (value == "Lunch") {
                      setState(() {
                        foodTypeList = lunchList;
                      });
                    } else if (value == "Dinner") {
                      setState(() {
                        foodTypeList = dinnerList;
                      });
                    } else if (value == "Deserts") {
                      setState(() {
                        foodTypeList = dessertList;
                      });
                    }
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    foodcategory = value.toString().replaceAll(' ', '');
                  },
                ),
                const SizedBox(height: 8,),
                // Row(
                //   children: [
                //     Checkbox(
                //       checkColor: Colors.white,
                //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                //       value: isBreakfastChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isBreakfastChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text("Breakfast"),
                //     Checkbox(  
                //       checkColor: Colors.white,
                //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                //       value: isDinnerChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isDinnerChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text("Dinner"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(
                //       checkColor: Colors.white,
                //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                //       value: isLunchChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isLunchChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text("Lunch      "),
                //     Checkbox(
                //       checkColor: Colors.white,
                //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                //       value: isSnackChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isSnackChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text("Snack"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(
                //       checkColor: Colors.white,
                //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                //       value: isDessertChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isDessertChecked = value!;
                //         });
                //       },
                //     ),
                //     const Text("Dessert      "),
                //   ],
                // ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Food Type :"),
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
                  items: foodTypeList
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
                      return 'Please select food type.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.

                  },
                  onSaved: (value) {
                    foodType = value.toString();
                  },
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Select Veg or Non Veg :"),
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
                  items: vegNonVegList
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
                      return 'Please select veg or non veg.';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    vegNonVeg = value.toString().replaceAll(' ', '');
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
                  items: diabetesTypeList
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
                    diabetesType = value.toString();
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
                            String clean_input = "";

                            setState(() {
                              isLoading = true;
                            });

                            if(foodcategory == "Breakfast"){
                              clean_input += "breakfast ";
                            }else{
                              clean_input += "notbreakfast ";
                            }

                            if(foodcategory == "Lunch"){
                              clean_input += "lunch ";
                            }else{
                              clean_input += "notlunch ";
                            }

                            if(foodcategory == "Dinner"){
                              clean_input += "dinner ";
                            }else{
                              clean_input += "notdinner ";
                            }

                            if(foodcategory == "Snack"){
                              clean_input += "snack ";
                            }else{
                              clean_input += "notsnack ";
                            }

                            if(foodcategory == "Desert"){
                              clean_input += "desert ";
                            }else{
                              clean_input += "notdesert ";
                            }

                            if(vegNonVeg == "Non Veg"){
                              vegNonVeg = "non";
                            }

                            clean_input += foodType+' ';
                            clean_input += vegNonVeg+ ' ';
                            
                            // if(diabetesType == "PreDiabetes"){
                            //   clean_input += "prediabetic ";
                            // }else{
                            //   clean_input += "nonprediabetic ";
                            // }

                            // if(diabetesType == "Diabetes"){
                            //   clean_input += "diabetic";
                            // }else{
                            //   clean_input += "nondiabetic";
                            // }

                            print(clean_input.toLowerCase());

                            String test ="notbreakfast notlunch notdinner snack notdesert snack veg prediabetic nondiabetic";
                            print(test);
                            var list = await FoodCalcService.getFoodRecommendationList(clean_input.toLowerCase());

                            print(list);

                            setState(() {
                              isLoading = false;
                            });
                            if (list == "") {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Food not found."),
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
                      "Food List",
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
                      //   child: Text("6. " + exercises[5]),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text("7. " + exercises[6]),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text("8. " + exercises[7]),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text("9. " + exercises[8]),
                      // ),
                      // const Divider(),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text("10. " + exercises[9]),
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

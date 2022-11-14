import 'package:flutter/material.dart';

const kPrimaryColor = Colors.teal;
const text_style =
    TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal);
const kSecondaryColor = Color(0xFFFF7F50);

enum QuesType {
  withTwoButton,
  withThreeButton,
  withSlider,
}

const mealTimeList = [
  'Breakfast',
  'Lunch',
  'Dinner',
  'Snack',
  'After meal',
  'Before meal',
  'Fasting'
];

IconData getMealIconByName(String name) {
  switch (name) {
    case 'Breakfast':
      return Icons.free_breakfast;
    case 'Lunch':
      return Icons.lunch_dining;
    case 'Dinner':
      return Icons.dinner_dining;
    case 'Snack':
      return Icons.local_pizza;
    case 'After meal':
      return Icons.restaurant_menu;
    case 'Before meal':
      return Icons.restaurant;
    case 'Fasting':
      return Icons.no_meals;
    default:
      return Icons.abc;
  }
}

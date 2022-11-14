class GPredictInput{
  final DateTime dateTime;
  final double glucose;

  GPredictInput({required this.dateTime, required this.glucose});

  Map toJson() {
    return {
      'dateTime': dateTime,
      'glucose': glucose
    };
  }
}
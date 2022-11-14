class LogEntry{
  final String? id;
  final DateTime dateTime;
  final double? glucoseLevel;
  final double? carbs;
  final double? insulin;
  final double? pill;
  final String? insulinType;
  final String? pillType;
  final String? mealType;
  final String userId; 

  LogEntry({
      this.id, 
      required this.dateTime, 
      this.glucoseLevel, 
      this.carbs,
      this.insulin,
      this.pill,
      this.insulinType,
      this.pillType,
      required this.userId, 
    this.mealType
  });
}
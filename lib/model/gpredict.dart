class GPredict{
  final DateTime dateTime;
  final double yhat;
  final double yhatLower;
  final double yhatUpper;

  GPredict({required this.dateTime, required this.yhat, required this.yhatLower, required this.yhatUpper});
}
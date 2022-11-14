
import 'package:diabeta_app/components/constants.dart';

class DiabetesQues{
  final int qno;
  final String question;
  final QuesType type;
  final List<String>? options;
  final double? minValue;
  final double? maxValue;
  late  double? defaultValue;
  final String? unit;
  final String? subText;
  final String? img;
  final String? des;

  DiabetesQues({required this.qno, required this.question, required this.type, this.options, this.minValue, this.maxValue, this.defaultValue, this.unit, this.subText, this.img, this.des});
}

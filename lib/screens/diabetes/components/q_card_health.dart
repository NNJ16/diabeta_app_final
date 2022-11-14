import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/diabetes_ques.dart';
import 'package:diabeta_app/model/diabetes_ques_ans.dart';
import 'package:diabeta_app/model/health_ques_ans.dart';
import 'package:flutter/material.dart';

class QHealthCard extends StatefulWidget {
  const QHealthCard({Key? key, required this.ques, required this.callBack})
      : super(key: key);
  final DiabetesQues ques;
  final Function() callBack;

  @override
  State<QHealthCard> createState() => _QCardState();
}

class _QCardState extends State<QHealthCard> {
  double _currentValue = 0;

  void setAnswer(){
    HealthQuestions.kidneyQuiz[widget.ques.qno-1].defaultValue = _currentValue; 
  }

  @override
  void initState() {
    _currentValue = widget.ques.defaultValue!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.ques.qno.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text(" of "),
                  Text(HealthQuestions.kidneyQuiz.length.toString())
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.ques.question,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              getRandomWidget(widget.ques.type),
              const SizedBox(
                height: 16,
              ),
              widget.ques.img != null ?  Image.asset(
                  "assets/images/"+widget.ques.img!,
                  width: 80,
                  height: 80,
                ): Container(),
              widget.ques.des != null ? Text(
                widget.ques.des!
              ): Container(),
              widget.ques.qno == HealthQuestions.kidneyQuiz.length ?
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      widget.callBack();
                    },
                    child: InkWell(
                      onTap: () async{
                        widget.callBack();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          border: Border.all(color: kSecondaryColor),
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),
                        height: 40,
                        width: 120,
                        child: const Center(child: Text('Predict', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRandomWidget(QuesType quesType) {
    switch (quesType) {
      case QuesType.withSlider:
        return Column(children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.ques.subText!),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_currentValue.toStringAsFixed(0)),
                    ),
                  ),
                  Text(" " + widget.ques.unit!)
                ],
              )
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: CustomTrackShape(),
              trackHeight: 16,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            ),
            child: Slider(
              value: _currentValue,
              max: widget.ques.maxValue!,
              min: widget.ques.minValue!,
              activeColor: kPrimaryColor,
              label: _currentValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentValue = value;
                  setAnswer();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.ques.minValue.toString()),
              Text(widget.ques.maxValue.toString()),
            ],
          ),
        ]);
      case QuesType.withTwoButton:
        return Column(children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _currentValue = 1;
                    setAnswer();
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color:
                            _currentValue == 1.0 ? kPrimaryColor : Colors.white,
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        widget.ques.options![0],
                        style: TextStyle(
                            fontSize: 16,
                            color: _currentValue == 1
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _currentValue = 0;
                    setAnswer();
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color:
                            _currentValue != 1.0 ? kPrimaryColor : Colors.white,
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        widget.ques.options![1],
                        style: TextStyle(
                            fontSize: 16,
                            color: _currentValue != 1
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
              ),
            ],
          )
        ]);
      default:
        return const Text("");
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

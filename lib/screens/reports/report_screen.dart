import 'package:diabeta_app/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../services/glucose_log_service.dart';

class SplineAreaWeightData {
  // SplineAreaData(this.year, this.y1, this.y2);
  // final double year;
  // final double y1;
  // final double y2;
  SplineAreaWeightData(this.title, this.value);
  final String title;
  final double value;
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late ChartSeriesController _chartSeriesController;
  List<SplineAreaWeightData> _chartGlucoseData = <SplineAreaWeightData>[];
  List<SplineAreaWeightData> _chartCarbData = <SplineAreaWeightData>[];
  final _currentUser = FirebaseAuth.instance.currentUser;
  int _gselectedIndex = 2;
  int _cselectedIndex = 2;

  void getChartGlucoseDataByTimeFrame() async {
    List<SplineAreaWeightData> _data = <SplineAreaWeightData>[];
    String period = "This week";
    if (_gselectedIndex == 1) {
      period = "This month";
    } else if (_gselectedIndex == 2) {
      period = "This year";
    }

    List data = await GlucoseLogService.getRecordsByTimeFrame(
        _currentUser!.uid, period,
        isDecending: false);
    data.forEach((element) {
      if (element.glucoseLevel != null) {
        _data.add(SplineAreaWeightData(
            DateFormat('MMM d').format(element.dateTime).toString(),
            element.glucoseLevel));
      }
    });
    setState(() {
      _chartGlucoseData = _data;
    });
  }

  void getChartCarbsDataByTimeFrame() async {
    List<SplineAreaWeightData> _data = <SplineAreaWeightData>[];
    String period = "This week";

    if (_cselectedIndex == 1) {
      period = "This month";
    } else if (_cselectedIndex == 2) {
      period = "This year";
    }
    List data = await GlucoseLogService.getRecordsByTimeFrame(_currentUser!.uid, period, isDecending: false);
    data.forEach((element) {
      if (element.carbs != null) {
        _data.add(SplineAreaWeightData(
            DateFormat('MMM d').format(element.dateTime).toString(),
            element.carbs));
      }
    });

    setState(() {
      _chartCarbData = _data;
    });
  }

  @override
  void initState() {
    getChartGlucoseDataByTimeFrame();
    getChartCarbsDataByTimeFrame();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _gselectedIndex = 0;
                          getChartGlucoseDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _gselectedIndex != 0
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "WEEK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _gselectedIndex = 1;
                          getChartGlucoseDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _gselectedIndex != 1
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "MONTH",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _gselectedIndex = 2;
                          getChartGlucoseDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _gselectedIndex != 2
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "YEAR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ChartCard(width, "Glucose", "mg/dL", _chartGlucoseData),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _cselectedIndex = 0;
                          getChartCarbsDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _cselectedIndex != 0
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "WEEK",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _cselectedIndex = 1;
                          getChartCarbsDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _cselectedIndex != 1
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "MONTH",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          _cselectedIndex = 2;
                          getChartCarbsDataByTimeFrame();
                        });
                      }),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 16) / 3,
                        decoration: BoxDecoration(
                            color: _cselectedIndex != 2
                                ? kPrimaryColor
                                : Colors.teal[300]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "YEAR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ChartCard(width, "Carbohydrates", "grams", _chartCarbData),
              //ChartCard(width,  "","mg/dL", _chartCarbData),
            ],
          ),
        ),
      ),
    );
  }

  Container ChartCard(double width, String title, String unit,
      List<SplineAreaWeightData> chartData) {
    return Container(
      height: 380,
      width: width - 20,
      margin: const EdgeInsets.only(top: 20.0),

      // width: size.width * 0.85,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            kPrimaryColor,
            // Color.fromARGB(255, 96, 207, 92),
            Color.fromARGB(255, 2, 102, 93),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // color: Colors.red[800],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 320,
              child: chartData.isEmpty
                  ? const Center(
                      child: Text(
                      "No data to display.",
                      style: TextStyle(color: Colors.white),
                    ))
                  : SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                      ),
                      enableAxisAnimation: true,
                      legend: Legend(isVisible: false, opacity: 0.7),
                      // title: ChartTitle(text: 'Inflation rate'),

                      plotAreaBorderWidth: 0,
                      primaryXAxis: CategoryAxis(
                          axisLine: AxisLine(
                            color: Colors.white,
                            width: 2,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          isVisible: true,
                          // maximumLabels: 5,
                          // interval: 1,
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                      primaryYAxis: NumericAxis(
                          axisLine: AxisLine(
                            color: Colors.white,
                            width: 2,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          isVisible: true,
                          labelFormat: '{value}',
                          // axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0)),
                      series: <ChartSeries>[
                        SplineAreaSeries<SplineAreaWeightData, String>(
                          // animationDuration: 100,
                          markerSettings: MarkerSettings(
                              isVisible: true,
                              borderColor: Colors.white,
                              height: 4,
                              width: 4),
                          // gradient: LinearGradient(
                          //   colors: <Color>[
                          //     Colors.white.withAlpha(100),
                          //     Colors.white.withAlpha(10),
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;

                            // setState(() {
                            //   _chartSeriesController = controller;
                            // });
                          },
                          enableTooltip: true,
                          dataSource: chartData,
                          borderColor: Colors.white,
                          splineType: SplineType.natural,
                          color: Colors.transparent,
                          borderWidth: 3,
                          name: unit,
                          xValueMapper: (SplineAreaWeightData data, _) =>
                              data.title,
                          yValueMapper: (SplineAreaWeightData data, _) =>
                              data.value,
                        )
                      ],
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

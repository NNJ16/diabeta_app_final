import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/components/log_card.dart';
import 'package:diabeta_app/components/menu_card.dart';
import 'package:diabeta_app/model/log_count.dart';
import 'package:diabeta_app/screens/diabetes/screens/glucose_log_screen.dart';
import 'package:diabeta_app/screens/reports/report_screen.dart';
import 'package:diabeta_app/services/diabates_predict_service.dart';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/glucose_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var entryCountList = <LogCount>[];
  late ChartSeriesController _chartSeriesController;
  List<SplineAreaWeightData> _chartData = <SplineAreaWeightData>[];
  List<SplineAreaWeightData> _chartData1 = <SplineAreaWeightData>[];
  final _currentUser = FirebaseAuth.instance.currentUser;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool ismodelCalled = false;

  int color = 0xFF34eb43;

  void _changeGlucoseColor(int glucose) {
    if (glucose > 315) {
      setState(() {
        color = 0xFFff0000;
      });
    } else if (glucose > 180) {
      setState(() {
        color = 0xFFfa5c5c;
      });
    } else if (glucose > 120) {
      setState(() {
        color = 0xFFff9d00;
      });
    } else if (glucose > 70) {
      setState(() {
        color = 0xFF34eb43;
      });
    } else if (glucose > 0) {
      setState(() {
        color = 0xFFff0000;
      });
    }
  }

  void getChartData() async {
    List<SplineAreaWeightData> _data = <SplineAreaWeightData>[];
    final SharedPreferences prefs = await _prefs;

    var glucoseData = [];
    List data = await GlucoseLogService.getRecordsByTimeFrame(
        _currentUser!.uid, "This year",
        isDecending: false);
    data.forEach((element) {
      _data.add(SplineAreaWeightData(
          DateFormat('MMM d').format(element.dateTime).toString(),
          element.glucoseLevel));
    });

    entryCountList =
        await GlucoseLogService.getRecordsCountByTimeFrame(_currentUser!.uid);
    setState(() {
      _chartData = _data;
    });

    List allData =
        await GlucoseLogService.getAllRecords(_currentUser!.uid, false);
    DateTime? lastDate;

    allData.forEach((element) {
      if (element.glucoseLevel != null) {
        lastDate = element.dateTime;
        glucoseData.add(Glucose(
                date:
                    DateFormat('d/MM/yyyy').format(element.dateTime).toString(),
                glucose: element.glucoseLevel)
            .toJson());
      }
    });

    if (prefs.getBool("isForecast") == null) {
      prefs.setBool("isForecast", true);
    }
    if (lastDate != null && prefs.getBool("isForecast")!) {
      String futureData = await DiabatesPredictService.getFuturGlucoseLevel(
          DateTime(lastDate!.year, lastDate!.month, lastDate!.day + 1),
          glucoseData);
      final list = jsonDecode(futureData);

      print(list["0"]["ds"]);
      print(list["1"]["ds"]);
      var date = list["0"]["ds"].toString().split("-");
      var date1 = list["1"]["ds"].toString().split("-");
      double glucose = list["0"]["yhat"];
      double glucose1 = list["1"]["yhat"];
      print(list["0"]["yhat"]);
      print(list["1"]["yhat"]);

      setState(() {
        _chartData1 = [
          SplineAreaWeightData(
              DateFormat('MMM d')
                  .format(DateTime(int.parse(date[0]), int.parse(date[1]),
                      int.parse(date[2])))
                  .toString(),
              glucose),
          SplineAreaWeightData(
              DateFormat('MMM d')
                  .format(DateTime(int.parse(date1[0]), int.parse(date1[1]),
                      int.parse(date1[2])))
                  .toString(),
              glucose1),
        ];
      });
    }
  }

  // void initialaizeLineChart() async {
  //   List data = await GlucoseLogService.getLast10GlucoseRecords('001');
  //   var gdata = <GlucoseData>[];
  //   data.forEach((element) {
  //     gdata.add(GlucoseData(
  //         DateFormat('MMM d').format(element.dateTime).toString(),
  //         element.glucoseLevel));
  //   });
  //   entryCountList = await GlucoseLogService.getRecordsCountByTimeFrame('001');
  //   setState(() {
  //     glucoseData = gdata;
  //   });
  // }

  @override
  void initState() {
    //initialaizeLineChart();
    getChartData();
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('2/Glucose');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
      if (mounted) {
        setState(() {
          if (data != 0 && !ismodelCalled) {
            ismodelCalled = true;
            showModelDialog(int.parse(data.toString()));
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: kSecondaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GlucoseLogScreen()),
            );
          },
          child: const Icon(Icons.add)),
      body: ListView(
        children: [
          // Center(
          //   child: Container(
          //     color: Colors.teal[100],
          //     height: 200,
          //     child: SfCartesianChart(
          //       primaryXAxis: CategoryAxis(),
          //       series: <LineSeries<GlucoseData, String>>[
          //         LineSeries<GlucoseData, String>(
          //             dataSource: glucoseData,
          //             dataLabelSettings: const DataLabelSettings(
          //                 isVisible: true,
          //                 textStyle: TextStyle(color: kSecondaryColor)),
          //             xValueMapper: (GlucoseData sales, _) => sales.date,
          //             yValueMapper: (GlucoseData sales, _) => sales.sales),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChartCard(width, "Blood Glucose", _chartData),
          ),
          Container(
            height: 200,
            child: Swiper(
              loop: false,
              itemCount: 3,
              itemHeight: 400.0,
              itemWidth: 600,
              duration: 1500,
              autoplayDelay: 8000,
              onIndexChanged: (index) {},
              layout: SwiperLayout.STACK,
              pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.grey, activeColor: Colors.white)),
              itemBuilder: (BuildContext context, int index) {
                return entryCountList.length > index
                    ? MenuCard(
                        logCount: entryCountList.elementAt(index),
                      )
                    : Container();
              },
            ),
          ),
          FutureBuilder(
            future: GlucoseLogService.getLast10Records(_currentUser!.uid),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                int length = snapshot.data!.length;
                return length > 0
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          length,
                          (index) {
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GlucoseLogScreen(
                                              title: 'Edit Entry',
                                              logEntry: snapshot.data![index],
                                            )),
                                  ).then((_) => setState(() {}));
                                },
                                child: LogCard(
                                  logEntry: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: [
                            Container(
                              child: Center(child: Text(" No records, yet.")),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              child: Center(
                                  child: Text(" Add your first record.")),
                            ),
                          ],
                        ),
                      );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Container ChartCard(
      double width, String title, List<SplineAreaWeightData> chartData) {
    return Container(
      height: 250,
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
              'Glucose Level',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: _chartData.isEmpty
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
                          dataSource: _chartData,
                          borderColor: Colors.white,
                          splineType: SplineType.natural,
                          color: Colors.transparent,
                          borderWidth: 3,
                          name: 'mg/dL',
                          xValueMapper: (SplineAreaWeightData data, _) =>
                              data.title,
                          yValueMapper: (SplineAreaWeightData data, _) =>
                              data.value,
                        ),
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
                          dataSource: _chartData1,
                          borderColor: kSecondaryColor,
                          splineType: SplineType.natural,
                          color: Colors.transparent,
                          borderWidth: 3,
                          name: 'mg/dL',
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

  void showModelDialog(int glucose) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getBool("isDiaBetaConnect") == null) {
      prefs.setBool("isDiaBetaConnect", false);
    } else {
      if (prefs.getBool("isDiaBetaConnect")!) {
        _changeGlucoseColor(glucose);
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              FirebaseDatabase.instance
                                  .ref('2/Glucose')
                                  .set(0)
                                  .then((_) {
                                ismodelCalled = false;
                                Navigator.pop(context);
                              }).catchError((error) {});
                            },
                          ),
                          const Text(
                            'Glucometer',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              setState(() {});
                              FirebaseDatabase.instance
                                  .ref('2/Glucose')
                                  .set(0)
                                  .then((_) {
                                ismodelCalled = false;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GlucoseLogScreen(
                                            glucose: glucose.toString(),
                                          )),
                                );
                              }).catchError((error) {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: kPrimaryColor,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/glucometer.png",
                            width: 250,
                            height: 350,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 145,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Glucose level",
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      glucose.toString() + " mg/dL",
                                      style: TextStyle(
                                          fontSize: 26, color: Color(color)),
                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 100.0),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         children: [
                              //           Text(
                              //             'Heart rate : ',
                              //             style: TextStyle(fontSize: 12),
                              //           ),
                              //           Text(
                              //             "187.53 bpm",
                              //             style: TextStyle(fontSize: 12),
                              //           )
                              //         ],
                              //       ),
                              //       Row(
                              //         children: [
                              //           Text(
                              //             'Oxygen level : ',
                              //             style: TextStyle(fontSize: 12),
                              //           ),
                              //           Text(
                              //             "97%",
                              //             style: TextStyle(fontSize: 12),
                              //           )
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }).whenComplete(_onBottomSheetClosed);
      }
    }
  }

  void _onBottomSheetClosed() {
    FirebaseDatabase.instance.ref('2/Glucose').set(0).then((_) {
      ismodelCalled = false;
    }).catchError((error) {});
  }
}

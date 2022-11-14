import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/log_entry.dart';
import 'package:diabeta_app/screens/diabetes/components/b_card.dart';
import 'package:diabeta_app/screens/main_screen.dart';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../components/yes_no_model.dart';

class GlucoseLogScreen extends StatefulWidget {
  final String title;
  final String? glucose;
  final LogEntry? logEntry;
  const GlucoseLogScreen({Key? key, this.title = "", this.logEntry, this.glucose})
      : super(key: key);

  @override
  State<GlucoseLogScreen> createState() => _GlucoseLogScreenState();
}

class _GlucoseLogScreenState extends State<GlucoseLogScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _glucoseController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _insulinController = TextEditingController();
  final TextEditingController _pillController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;

  int selectedIndex = 0;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  int color = 0xFF34eb43;
  String _title = "Log Entry";
  String insulinValue = "";
  String pillValue = "";

  var insulin = [
    '',
    'Insulin Aspart',
    'Insulin Lispro',
    'Soluble insulin',
    'Isophane',
    'NPH',
  ];

  var pills = [
    '',
    'Metformin',
    'Glipizide',
    'Glimepiride',
    'Invokana',
    'Jardiance',
  ];

  @override
  void initState() {
    if(widget.glucose != null){
      _glucoseController.text = widget.glucose!;
      _changeGlucoseColor(int.parse(widget.glucose!));
    }
    if (widget.title != "") {
      if (widget.logEntry!.glucoseLevel != null) {
        _changeGlucoseColor(widget.logEntry!.glucoseLevel!.toInt());
        _glucoseController.text = widget.logEntry!.glucoseLevel.toString();
      }
      if (widget.logEntry!.carbs != null) {
        _carbsController.text = widget.logEntry!.carbs.toString();
      }
      if (widget.logEntry!.insulin != null) {
        _insulinController.text = widget.logEntry!.insulin.toString();
      }
      if (widget.logEntry!.pill != null) {
        _pillController.text = widget.logEntry!.pill.toString();
      }
      if (widget.logEntry!.insulinType != null) {
        insulinValue = widget.logEntry!.insulinType.toString();
      }
      if (widget.logEntry!.pillType != null) {
        pillValue = widget.logEntry!.pillType.toString();
      }

      date = widget.logEntry!.dateTime;
      time = TimeOfDay.fromDateTime(widget.logEntry!.dateTime);

      selectedIndex =
          mealTimeList.indexOf(widget.logEntry!.mealType.toString());

      setState(() {
        _title = widget.title;
      });
    }
    super.initState();
  }

  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<bool> _addRecord() async {
    FocusScope.of(context).requestFocus(FocusNode());
    LogEntry logEntry = LogEntry(
        dateTime:
            DateTime(date.year, date.month, date.day, time.hour, time.minute),
        glucoseLevel: _glucoseController.text != ""
            ? double.parse(_glucoseController.text.toString())
            : null,
        carbs: _carbsController.text != ""
            ? double.parse(_carbsController.text.toString())
            : null,
        insulin: _insulinController.text != ""
            ? double.parse(_insulinController.text.toString())
            : null,
        pill: _pillController.text != ""
            ? double.parse(_pillController.text.toString())
            : null,
        insulinType: insulinValue,
        pillType: pillValue,
        mealType: mealTimeList[selectedIndex],
        userId: _currentUser!.uid);

    String result = await GlucoseLogService.addRecord(logEntry);
    return result != "";
  }

  Future<bool> _editRecord() async {
    FocusScope.of(context).requestFocus(FocusNode());
    LogEntry logEntry = LogEntry(
        dateTime:
            DateTime(date.year, date.month, date.day, time.hour, time.minute),
        glucoseLevel: _glucoseController.text != ""
            ? double.parse(_glucoseController.text.toString())
            : null,
        carbs: _carbsController.text != ""
            ? double.parse(_carbsController.text.toString())
            : null,
        insulin: _insulinController.text != ""
            ? double.parse(_insulinController.text.toString())
            : null,
        pill: _pillController.text != ""
            ? double.parse(_pillController.text.toString())
            : null,
        insulinType: insulinValue,
        pillType: pillValue,
        mealType: mealTimeList[selectedIndex],
        userId: _currentUser!.uid);

    return await GlucoseLogService.editRecord(logEntry, widget.logEntry!.id);
  }

  Future<void> _deleteRecord(BuildContext context) async {
    bool result = await GlucoseLogService.deleteRecord(widget.logEntry!.id);
    if (result) {
      Navigator.pop(context);
    }
  }

  Future pickDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  Future pickTime(BuildContext context) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        time = result;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String? _mandatoryValidator(String? text) {
    if (text!.isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_title),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: (widget.title != "Edit Entry"
            ? <Widget>[
                IconButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result = await _addRecord();
                      if (result) {
                                            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen()),
                    );
                      }
                    }
                  },
                  icon: const Icon(Icons.done),
                )
              ]
            : <Widget>[
                IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => (YesNoModel(
                          buildContext: context,
                          msg: "Are you sure you want to delete this entry?",
                          callBack: _deleteRecord)),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () async {
                    bool result = await _editRecord();
                    if (result) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.done),
                )
              ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.grey[300]!),
              )),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.calendar, color: kPrimaryColor),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Date'),
                      ],
                    ),
                    InkWell(
                      child: Text(DateFormat('MMMM dd, yyyy').format(date)),
                      onTap: () {
                        pickDate(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.grey[300]!),
              )),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.clock, color: kPrimaryColor),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Time'),
                      ],
                    ),
                    InkWell(
                      child: Text(formatTimeOfDay(time)),
                      onTap: () {
                        pickTime(context);
                      },
                    )
                  ],
                ),
              ),
            ),

            // const Padding(
            //   padding: EdgeInsets.only(top: 8.0, bottom: 8),
            //   child: Text(
            //     'Do you test your blood glucose?',
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 16.0, bottom: 16),
            //   child: Text(
            //     'What is your latest blood glucose reading?',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              FaIcon(FontAwesomeIcons.droplet,
                                  color: kPrimaryColor),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Glucose'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(color),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 60,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _glucoseController,
                                    onChanged: (value) {
                                      try {
                                        int glucose = int.parse(value);
                                        _changeGlucoseColor(glucose);
                                      } catch (e) {
                                        _changeGlucoseColor(0xFF34eb43);
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        isCollapsed: true),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text('mg/dL'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              FaIcon(FontAwesomeIcons.breadSlice,
                                  color: kPrimaryColor),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Carbs'),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 60,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _carbsController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        isCollapsed: true),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text('grams'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.syringe,
                                  color: kPrimaryColor),
                              SizedBox(
                                width: 8,
                              ),
                              DropdownButton(
                                // Initial Value
                                value: insulinValue,
                                isDense: true,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: insulin.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    insulinValue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 60,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _insulinController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        isCollapsed: true),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(' Units'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.capsules,
                                  color: kPrimaryColor),
                              SizedBox(
                                width: 8,
                              ),
                              DropdownButton(
                                isDense: true,
                                // Initial Value
                                value: pillValue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: pills.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    pillValue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 60,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _pillController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        isCollapsed: true),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(' Units'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   decoration: BoxDecoration(
            //       border: Border(
            //     bottom: BorderSide(width: 1.5, color: Colors.grey[300]!),
            //   )),
            //   width: double.infinity,
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const Text('Insulin'),
            //         Row(
            //           children: [
            //             const Icon(Icons.vaccines, color: kPrimaryColor,),
            //             const SizedBox(
            //               width: 15,
            //             ),
            //             SizedBox(
            //               width: 60,
            //               child: TextFormField(
            //                 decoration: const InputDecoration(
            //                   border: InputBorder.none,
            //                   isDense: true,
            //                   isCollapsed: true
            //                 ),
            //               ),
            //             ),
            //             const Text('Units'),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 16.0, bottom: 16),
            //   child: Text(
            //     'Blood glucose test was taken...',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]!),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                childAspectRatio: 1.2 / 1,
                children: <Widget>[
                  Bcard(
                    text: mealTimeList[0],
                    iconData: Icons.free_breakfast,
                    index: 0,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[1],
                    iconData: Icons.lunch_dining,
                    index: 1,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[2],
                    iconData: Icons.dinner_dining,
                    index: 2,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[3],
                    iconData: Icons.local_pizza,
                    index: 3,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[4],
                    iconData: Icons.restaurant_menu,
                    index: 4,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[5],
                    iconData: Icons.restaurant,
                    index: 5,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                  Bcard(
                    text: mealTimeList[6],
                    iconData: Icons.no_meals,
                    index: 6,
                    selectedindex: selectedIndex,
                    callback: setIndex,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

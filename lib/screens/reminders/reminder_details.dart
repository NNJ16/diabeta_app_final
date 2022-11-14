import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/ReceivedNotification.dart';
import 'package:diabeta_app/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReminderDetails extends StatefulWidget {
  final String? activity;
  final String? dateTime;
  const ReminderDetails({Key? key, this.activity, this.dateTime})
      : super(key: key);

  @override
  _ReminderDetailsState createState() => _ReminderDetailsState();
}

class _ReminderDetailsState extends State<ReminderDetails> {
  late final LocalNotificationService service;
  DateTime pickedDate = DateTime.now();
  String notificationBody = '';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    if (widget.activity != null && widget.dateTime != null) {
      notificationBody = widget.activity.toString();
      pickedDate = DateTime.parse(widget.dateTime.toString());
      date = DateTime.parse(widget.dateTime.toString());
      time = TimeOfDay.fromDateTime(DateTime.parse(widget.dateTime.toString()));
    }
    listenToNotification();
    super.initState();
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
      print(newDate);
      date = newDate;
    });
  }

  Future pickTime(BuildContext context, DateTime date) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        print(result);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Reminder"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: (<Widget>[
          IconButton(
            onPressed: () async {
              date = DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);
              try {
                await service.setScheduledNotification(
                  id: 0,
                  body: notificationBody ?? widget.activity ?? 'Not Found',
                  dateAndTime: date,
                );
                ReceivedNotification receivedNotification =
                    new ReceivedNotification(
                        id: 0,
                        title: "Diabeta Activity",
                        body: notificationBody,
                        payload: date.toString());
                // await DataStore.shared.setReminderList(receivedNotification);
                Navigator.pop(context, receivedNotification);
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter Valid Date"),
                  duration: Duration(milliseconds: 2000),
                ));
                // Fluttertoast.showToast(
                //     msg: "Enter Valid Date",
                //     backgroundColor: Color.fromARGB(255, 77, 77, 77),
                //     textColor: Colors.white,
                //     fontSize: 15.0);
              }
            },
            icon: const Icon(Icons.done),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, bottom: 0),
                  child: Text(
                    "Title",
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        // labelText: 'Title',
                        ),
                    initialValue: widget.activity ?? '',
                    // controller: TextEditingController(text: widget.activity ?? ''),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        notificationBody = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
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
                            FaIcon(FontAwesomeIcons.calendar,
                                color: kPrimaryColor),
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
                            FaIcon(FontAwesomeIcons.clock,
                                color: kPrimaryColor),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Time'),
                          ],
                        ),
                        InkWell(
                          child: Text(formatTimeOfDay(time)),
                          onTap: () {
                            pickTime(context, date);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     date = DateTime(date.year, date.month, date.day, time.hour,
                //         time.minute);
                //     try {
                //       await service.setScheduledNotification(
                //         id: 0,
                //         body:
                //             notificationBody ?? widget.activity ?? 'Not Found',
                //         dateAndTime: date,
                //       );
                //       ReceivedNotification receivedNotification =
                //           new ReceivedNotification(
                //               id: 0,
                //               title: "Diabeta Activity",
                //               body: notificationBody,
                //               payload: date.toString());
                //       // await DataStore.shared.setReminderList(receivedNotification);
                //       Navigator.pop(context, receivedNotification);
                //     } catch (e) {
                //       print(e);
                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text("Enter Valid Date"),
                //         duration: Duration(milliseconds: 2000),
                //       ));
                //       // Fluttertoast.showToast(
                //       //     msg: "Enter Valid Date",
                //       //     backgroundColor: Color.fromARGB(255, 77, 77, 77),
                //       //     textColor: Colors.white,
                //       //     fontSize: 15.0);
                //     }
                //   },
                //   child: const Text('Save Reminder'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}

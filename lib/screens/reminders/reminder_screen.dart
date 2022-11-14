import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/reminders/reminder_details.dart';
import 'package:diabeta_app/services/data_store.dart';
import 'package:diabeta_app/services/local_notification_service.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late final LocalNotificationService service;
  DateTime pickedDate = DateTime.now();
  String notificationBody = '';
  List<dynamic> reminderList = [];
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
    DataStore.shared.getReminderList().then((value) {
      setState(() {
        reminderList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: kSecondaryColor,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderDetails()))
                      .then((payload) {
                    if (payload != null) {
                      DataStore.shared.setReminderList(payload);

                      DataStore.shared.getReminderList().then((value) {
                        setState(() {
                          reminderList = value;
                        });
                      });
                    }

                    // DataStore.shared.getReminderList().then((value) {
                    //   setState(() {
                    //     reminderList = value;
                    //   });
                    // });
                  });
                },
                child: const Icon(Icons.add)),
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 17.0, left: 17.0, right: 17.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // const Text(
                    //   'This is a demo of how to use local notifications in Flutter.',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          // physics: ,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Card(
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReminderDetails(
                                                      activity:
                                                          reminderList[index]
                                                              ["body"],
                                                      dateTime: reminderList[
                                                              index]
                                                          ["payload"]))).then(
                                          (payload) {
                                        if (payload != null) {
                                          reminderList.removeAt(index);
                                          reminderList.add({
                                            "id": payload.id,
                                            "body": payload.body,
                                            "payload": payload.payload,
                                            "title": payload.title,
                                          });
                                          DataStore.shared.setReminderFullList(
                                              reminderList);

                                          DataStore.shared
                                              .getReminderList()
                                              .then((value) {
                                            setState(() {
                                              reminderList = value;
                                            });
                                          });
                                        }
                                      });
                                    },
                                    leading:
                                        CircleAvatar(child: Icon(Icons.alarm)),
                                    title: Text(
                                        reminderList[index]["body"].toString()),
                                    subtitle: Text(reminderList[index]
                                            ["payload"]
                                        .toString()
                                        .substring(0, 16)),
                                    trailing: GestureDetector(
                                      onTap: () async {
                                        print(index);
                                        reminderList.removeAt(index);
                                        await DataStore.shared
                                            .setReminderFullList(reminderList);
                                        setState(() {});
                                      },
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        radius: 10,
                                        backgroundColor: Colors.red[800],
                                      ),
                                    )),
                              ),
                            );
                          },
                          itemCount: reminderList.length),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 12.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     heightFactor: 130.0,
          //     widthFactor: 130.0,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           shape: const CircleBorder(),
          //           backgroundColor: kSecondaryColor),
          //       onPressed: () {
          //         Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => ReminderDetails()))
          //             .then((payload) {
          //           if (payload != null) {
          //             DataStore.shared.setReminderList(payload);

          //             DataStore.shared.getReminderList().then((value) {
          //               setState(() {
          //                 reminderList = value;
          //               });
          //             });
          //           }

          //           // DataStore.shared.getReminderList().then((value) {
          //           //   setState(() {
          //           //     reminderList = value;
          //           //   });
          //           // });
          //         });
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: const Icon(Icons.add, size: 30.0),
          //       ),
          //     ),
          //   ),
          // ),
        ],
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

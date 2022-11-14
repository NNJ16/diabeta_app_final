import 'package:diabeta_app/model/account_info.dart';
import 'package:diabeta_app/screens/diabetes/screens/logbook_screen.dart';
import 'package:diabeta_app/screens/diabetes/screens/print_log_screen.dart';
import 'package:diabeta_app/screens/exercise/exercise_main_screen.dart';
import 'package:diabeta_app/screens/food/food_main_screen.dart';
import 'package:diabeta_app/screens/health_check_screen.dart';
import 'package:diabeta_app/screens/dashboard_screen.dart';
import 'package:diabeta_app/screens/reminders/reminder_screen.dart';
import 'package:diabeta_app/screens/reports/report_screen.dart';
import 'package:diabeta_app/screens/settings/settings_screen.dart';
import 'package:diabeta_app/services/account_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String period = "All records";
  String _title = "DiaBeta";
  final _currentUser = FirebaseAuth.instance.currentUser;
  String fullname = "";

  @override
  void initState() {
    getAccountInfo();
    super.initState();
  }

  void getAccountInfo() async {
    AccountInfo accountInfo =
        await AccountService.getAccountInfoByID(_currentUser!.uid);
    setState(() {
      fullname = accountInfo.fullname ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const DashboardScreen(),
      LogbookScreen(period: period),
      const HealthCheckScreen(),
      const FoodMainScreen(),
      const ExerciseMainScreen(),
      const ReminderScreen(),
      const ReportScreen(),
      const SettingsScreen()
    ];

    void setPeriodForLogbook(String p) {
      setState(() {
        period = p;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: _title != "Logbook"
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    showBottomSheet(setPeriodForLogbook, period);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrintLogScreen(period: period)),
                    );
                  },
                )
              ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                        radius: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        fullname,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                      ),
                      child: Text(_currentUser!.email.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.book,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Dashboard')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _title = "DiaBeta";
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.note_alt,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logbook')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    _title = "Logbook";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.health_and_safety,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Health')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                    _title = "Health";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.food_bank,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Food')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                    _title = "Food";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.directions_run,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Exercise')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                    _title = "Exercise";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.add_alert,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Reminders')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 5;
                    _title = "Reminders";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.timeline,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Report')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 6;
                    _title = "Reports";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.settings,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Settings')
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 7;
                    _title = "Settings";
                  });
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   title: Row(
              //     children: const [
              //       Icon(
              //         Icons.exit_to_app,
              //         color: kPrimaryColor,
              //       ),
              //       SizedBox(
              //         width: 8,
              //       ),
              //       Text('Logout')
              //     ],
              //   ),
              //   onTap: () async {

              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(Function(String) callBack, String p) {
    String period = p;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
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
                                  Navigator.pop(context);
                                },
                              ),
                              const Text(
                                'Filter',
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
                                  callBack(period);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Container(
                        height: 32,
                        width: double.infinity,
                        color: Colors.teal[200],
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4.0, left: 4),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Period',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            period = "This week";
                          });
                        },
                        child: Container(
                          height: 32,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'This week',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  period == "This week"
                                      ? const Icon(Icons.done)
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            period = "This month";
                          });
                        },
                        child: Container(
                          height: 32,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'This month',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  period == "This month"
                                      ? const Icon(Icons.done)
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            period = "This year";
                          });
                        },
                        child: Container(
                          height: 32,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'This year',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  period == "This year"
                                      ? const Icon(Icons.done)
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            period = "All records";
                          });
                        },
                        child: Container(
                          height: 32,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'All records',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  period == "All records"
                                      ? const Icon(Icons.done)
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ));
          });
        });
  }
}

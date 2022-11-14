import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/diabetes/screens/print_log_screen.dart';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/yes_no_model.dart';

class OtherSettingsScreen extends StatefulWidget {
  const OtherSettingsScreen({Key? key}) : super(key: key);

  @override
  State<OtherSettingsScreen> createState() => _OtherSettingsScreenState();
}

class _OtherSettingsScreenState extends State<OtherSettingsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isAppLock = false;
  bool isForecast = false;
  bool isDiaBetaConnect = false;

  @override
  void initState() {
    initializevalues();
    super.initState();
  }

  Future<void> initializevalues() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getBool("isForecast") == null) {
      prefs.setBool("isForecast", false);
    } else if (prefs.getBool("isAppLock") == null) {
      prefs.setBool("isAppLock", false);
    } else if (prefs.getBool("isDiaBetaConnect") == null) {
      prefs.setBool("isDiaBetaConnect", false);
    }

    setState(() {
      isForecast = prefs.getBool("isForecast")!;
      isAppLock = prefs.getBool("isAppLock")!;
      isDiaBetaConnect = prefs.getBool("isDiaBetaConnect")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Settings"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 16, right: 16),
            //       child: Image.asset(
            //         "assets/images/settings.png",
            //         width: 70,
            //         height: 70,
            //       ),
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text(
            //           "No need to change these, ",
            //           style: TextStyle(color: Colors.grey),
            //         ),
            //         SizedBox(
            //           height: 4,
            //         ),
            //         Text(
            //           "but of course you can.",
            //           style: TextStyle(color: Colors.grey),
            //         )
            //       ],
            //     )
            //   ],
            // ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Privacy',
              style: TextStyle(fontSize: 12, color: kPrimaryColor),
            ),
            Divider(),
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "App Lock",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isAppLock,
                        onChanged: (value) async {
                          final SharedPreferences prefs = await _prefs;
                          setState(() {
                            prefs
                                .setBool('isAppLock', value)
                                .then((bool success) {
                              isAppLock = value;
                            });
                          });
                        },
                        activeTrackColor: Colors.teal[300],
                        activeColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              "Require screen lock when you open the app.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Your personal and medical data',
              style: TextStyle(fontSize: 12, color: kPrimaryColor),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrintLogScreen(
                            period: 'All records',
                          )),
                );
              },
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Export data",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text(
              "Export all your data in the app.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Divider(),
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Forecast glucose level",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isForecast,
                        onChanged: (value) async {
                          final SharedPreferences prefs = await _prefs;
                          setState(() {
                            prefs
                                .setBool('isForecast', value)
                                .then((bool success) {
                              isForecast = value;
                            });
                          });
                        },
                        activeTrackColor: Colors.teal[300],
                        activeColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              "Forecast your glucose level for next two days.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Divider(),
            Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Connect DiaBeta device",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isDiaBetaConnect,
                        onChanged: (value) async {
                          final SharedPreferences prefs = await _prefs;
                          setState(() {
                            prefs
                                .setBool('isDiaBetaConnect', value)
                                .then((bool success) {
                              isDiaBetaConnect = value;
                            });
                          });
                        },
                        activeTrackColor: Colors.teal[300],
                        activeColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              "Automatically connect to DiaBeta device",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Account',
              style: TextStyle(fontSize: 12, color: kPrimaryColor),
            ),
            Divider(),
            InkWell(
              onTap: () {
                showDeleteAccount();
              },
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Delete my account",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text(
              "If you delete your account, your data will gone forever.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  void showDeleteAccount() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeleteAccount();
      },
    );
  }
}

class DeleteAccount extends StatelessWidget {
  DeleteAccount({Key? key}) : super(key: key);
  final _currentUser = FirebaseAuth.instance.currentUser;
  Future<void> _deletedatByUser(BuildContext context) async {
    await GlucoseLogService.deleteDataByUser(_currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Are you sure?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              const Text(
                'Delete account?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              Image.asset(
                "assets/images/heart.jpg",
                width: 100,
                height: 150,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "We're so sad to see you go. Please be aware that by deleting your account, your data will be gone forever.",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                    height: 45, width: double.infinity),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => (YesNoModel(
                          buildContext: context,
                          msg: "Are you sure you want to delete your acount?",
                          callBack: _deletedatByUser)),
                    );
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 0,
                    primary: Colors.redAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

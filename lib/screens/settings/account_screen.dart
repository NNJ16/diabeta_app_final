import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/account_info.dart';
import 'package:diabeta_app/services/account_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String genderValue = "";
  String diabetesValues = "";
  DateTime? dobDate = null;
  DateTime? yodDate = null;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;
  bool isAccountExist = false;
  AccountInfo accountInfo = new AccountInfo();

  var genders = [
    '',
    'Male',
    'Female',
  ];

  var diabetes = ['', 'Type 1', 'Type 2', 'Other'];

  @override
  void initState() {
    getAccountInfo();
    super.initState();
  }

  void getAccountInfo() async {
    accountInfo = await AccountService.getAccountInfoByID(_currentUser!.uid);
    if (accountInfo.email != null) {
      isAccountExist = true;
    }

    _emailController.text = _currentUser!.email!;
    _mobileController.text =
        accountInfo.mobile != null ? accountInfo.mobile! : "";
    _nameController.text =
        accountInfo.fullname != null ? accountInfo.fullname! : "";
    setState(() {
      genderValue = accountInfo.gender != null ? accountInfo.gender! : "";
      diabetesValues =
          accountInfo.diabetesType != null ? accountInfo.diabetesType! : "";
      yodDate = accountInfo.yod;
      dobDate = accountInfo.dob;
    });
  }

  Future pickDOBDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final initialDate = DateTime(1990);
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year - 5));
    if (newDate == null) return;
    setState(() {
      dobDate = newDate;
    });
  }

  Future pickYODDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime.now());
    if (newDate == null) return;
    setState(() {
      yodDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About me"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Info',
                  style: TextStyle(fontSize: 12, color: kPrimaryColor),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(fontSize: 14),
                            ),
                            Container(
                              width: 180,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      isCollapsed: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(fontSize: 14),
                            ),
                            Container(
                              width: 180,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: TextFormField(
                                  enabled: false,
                                  style: const TextStyle(color: Colors.grey),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      isCollapsed: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mobile No",
                              style: TextStyle(fontSize: 14),
                            ),
                            Container(
                              width: 180,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _mobileController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      isCollapsed: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Basic therapy info',
                  style: TextStyle(fontSize: 12, color: kPrimaryColor),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Diabetes Type",
                              style: TextStyle(fontSize: 14),
                            ),
                            DropdownButton(
                              // Initial Value
                              value: diabetesValues,
                              isDense: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: diabetes.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  diabetesValues = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(fontSize: 14),
                            ),
                            DropdownButton(
                              // Initial Value
                              value: genderValue,
                              isDense: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: genders.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  genderValue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date of birth",
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              child: dobDate == null
                                  ? Text("Not Set")
                                  : Text(DateFormat('MMMM dd, yyyy')
                                      .format(dobDate!)),
                              onTap: () {
                                pickDOBDate(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Year of diagnosis",
                              style: TextStyle(fontSize: 14),
                            ),
                            InkWell(
                              child: yodDate == null
                                  ? Text("Not Set")
                                  : Text(DateFormat('MMMM dd, yyyy')
                                      .format(yodDate!)),
                              onTap: () {
                                pickYODDate(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Text(
                  "Sex, age and diabetes duration affect your metabolism.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 32,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      height: 35, width: double.infinity),
                  child: ElevatedButton(
                    onPressed: () async {
                      AccountInfo accountInfo1 = AccountInfo(
                          uid: _currentUser!.uid,
                          fullname: _nameController.text,
                          email: _emailController.text,
                          mobile: _mobileController.text,
                          diabetesType: diabetesValues,
                          dob: dobDate,
                          gender: genderValue,
                          yod: yodDate);

                      if (isAccountExist) {
                        bool result = await AccountService.editRecord(
                            accountInfo1, accountInfo.id);

                        if (result) {
                          const snackBar = SnackBar(
                              content:
                                  Text("Account info updated successfully."),
                              backgroundColor: kPrimaryColor);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        String? id =
                            await AccountService.addRecord(accountInfo1);
                        if (id != null) {
                          const snackBar = SnackBar(
                              content: Text("Account info saved successfully."),
                              backgroundColor: kPrimaryColor);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text(
                      'Save changes',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 0,
                      primary: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      height: 35, width: double.infinity),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {}
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 0,
                      primary: kSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

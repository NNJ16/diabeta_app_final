import 'package:diabeta_app/components/constants.dart';
import 'package:flutter/material.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black87,
                size: 20,
              ))
        ],
        title: const Text(
          "Subscribe",
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: const Text(
                  "Choose your favourite plan and do something good for you and your diabetes.",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.asset(
                        "assets/images/pro.png",
                        width: double.infinity,
                        height: 150,
                      ),
                    ),
                    Text("DiaBeta Pro", style: TextStyle(fontSize: 20, color: kPrimaryColor, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: kPrimaryColor,
                          ),
                          Text(" App Lock")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: kPrimaryColor,
                          ),
                          Text(" Connect DiaBeta device")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: kPrimaryColor,
                          ),
                          Text(" Forecast future glucose")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: kPrimaryColor,
                          ),
                          Text(" PDF Reports")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Monthly",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "LKR 295",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(" per month")
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(
                                      height: 45, width: double.infinity),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Subscribe',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      elevation: 0,
                                      primary: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Cancel your subcrption at any time."),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Yearly",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "LKR 2895",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(" per year")
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(
                                      height: 45, width: double.infinity),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Subscribe',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      elevation: 0,
                                      primary: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Cancel your subcrption at any time."),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

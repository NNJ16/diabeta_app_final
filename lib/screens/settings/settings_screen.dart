import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/settings/account_screen.dart';
import 'package:diabeta_app/screens/settings/other_settings_screen.dart';
import 'package:diabeta_app/screens/settings/subscribe_screen.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 40,
                            color: kPrimaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "  About me",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "  Email, diabetes type & more",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubscribeScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My subcription",
                    ),
                    Text("PRO")
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
        Divider(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  showSupportFeedbackPage();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.contact_support,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "  Support & Feedback",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: InkWell(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const AccountScreen()),
        //           );
        //         },
        //         child: Container(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Row(
        //                 children: [
        //                   Icon(
        //                     Icons.emoji_events,
        //                     size: 25,
        //                     color: kPrimaryColor,
        //                   ),
        //                   Text(
        //                     "  Challenges",
        //                     style: TextStyle(fontSize: 14),
        //                   ),
        //                 ],
        //               ),
        //               Icon(
        //                 Icons.arrow_forward_ios,
        //                 size: 16,
        //                 color: kPrimaryColor,
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // Divider(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.class_,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "  User Manual",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  showRecommendDiaBetaView();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "  Recommend DiaBeta",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OtherSettingsScreen()),
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          Text(
                            "  Other settings",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  void showSupportFeedbackPage() {
    showDialog(
        context: context,
        builder: (context) {
          return SupportDialog();
        });
  }

  void showRecommendDiaBetaView() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return RecommedDiaBeta();
        });
  }
}

class RecommedDiaBeta extends StatefulWidget {
  const RecommedDiaBeta({Key? key}) : super(key: key);

  @override
  State<RecommedDiaBeta> createState() => _RecommedDiaBetaState();
}

class _RecommedDiaBetaState extends State<RecommedDiaBeta> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          children: [
            const Text(
              'Like DiaBeta? Share the love!',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: 16,
            ),
            Image.asset(
              "assets/images/share.png",
              width: 150,
              height: 200,
            ),
            SizedBox(
              height: 16,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                  height: 45, width: double.infinity),
              child: ElevatedButton(
                onPressed: () {
                  Share.share(
                      'Visit our website https://diabeta.000webhostapp.com/educations.html');
                  Navigator.pop(context);
                },
                child: const Text(
                  'Share with friends',
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
            const Text(
              'Thank you!',
              style: TextStyle(fontSize: 14, color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportDialog extends StatefulWidget {
  const SupportDialog({Key? key}) : super(key: key);

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  double rating = 5;
  TextEditingController _bodyController = TextEditingController();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text + "\n User rating : " + rating.toString(),
      subject: "DiaBeta Support and Feedback",
      recipients: ["diabetasystem@gmail.com"],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 370,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'What is your rate?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: kPrimaryColor,
                  borderColor: kPrimaryColor,
                  spacing: 0.0),
              SizedBox(
                height: 32,
              ),
              const Text(
                'Please share your opinion?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: _bodyController,
                maxLines: 6,
                minLines: 5,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.teal))),
              ),
              SizedBox(
                height: 16,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                    height: 45, width: double.infinity),
                child: ElevatedButton(
                  onPressed: () {
                    send();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 0,
                    primary: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/log_count.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MenuCard extends StatefulWidget {
  MenuCard({Key? key, required this.logCount}) : super(key: key);
  LogCount logCount;
  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
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
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.teal[200],
        ),
        child: getWidgetByIndex(widget.logCount.index),
      ),
    );
  }

  Widget getWidgetByIndex(int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'LATEST CHECK ' +
                  DateFormat('MM/dd/yyyy')
                      .format(widget.logCount.dateTime ?? DateTime.now()) +
                  ' ' +
                  DateFormat.jm()
                      .format(widget.logCount.dateTime ?? DateTime.now()),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'WEEKLY ENTRIES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'In Range',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            widget.logCount.inrange.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Below',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.below.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Above',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.above.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'LATEST CHECK ' +
                  DateFormat('MM/dd/yyyy')
                      .format(widget.logCount.dateTime ?? DateTime.now()) +
                  ' ' +
                  DateFormat.jm()
                      .format(widget.logCount.dateTime ?? DateTime.now()),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'MONTHLY ENTRIES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'In Range',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            widget.logCount.inrange.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Below',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.below.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Above',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.above.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Text(
              'LATEST CHECK ' +
                  DateFormat('MM/dd/yyyy')
                      .format(widget.logCount.dateTime ?? DateTime.now()) +
                  ' ' +
                  DateFormat.jm()
                      .format(widget.logCount.dateTime ?? DateTime.now()),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'YEARLY ENTRIES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'In Range',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            widget.logCount.inrange.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Below',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.below.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Above',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            size: 30,
                            color: kSecondaryColor,
                          ),
                          Text(
                            widget.logCount.above.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}

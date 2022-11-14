import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/log_card.dart';
import '../../../services/glucose_log_service.dart';
import 'glucose_log_screen.dart';

class LogbookScreen extends StatefulWidget {
  LogbookScreen({Key? key, required this.period}) : super(key: key);
  String period = "This year";

  @override
  State<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: GlucoseLogService.getRecordsByTimeFrame(_currentUser!.uid, widget.period),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            int length = snapshot.data!.length;
            return length>0 ? ListView(
              shrinkWrap: true,
              children: List.generate(length, (index) {
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
              }),
            ): Container(child: Center(child: Text("No data to display."),),);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

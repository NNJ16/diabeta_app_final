import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabeta_app/model/log_count.dart';
import 'package:diabeta_app/model/log_entry.dart';

class GlucoseLogService {
  static final CollectionReference _records =
      FirebaseFirestore.instance.collection('log_entries');

  static Future<String> addRecord(LogEntry logEntry) {
    return _records.add({
      'dateTime': logEntry.dateTime,
      'mealType': logEntry.mealType,
      'glucoseLevel': logEntry.glucoseLevel,
      'carbs': logEntry.carbs,
      'insulin': logEntry.insulin,
      'pill': logEntry.pill,
      'insulinType': logEntry.insulinType,
      'pillType': logEntry.pillType,
      'userId': logEntry.userId,
    }).then((value) {
      return value.id;
    }).catchError((error) {
      return "";
    });
  }

  static Future<bool> editRecord(LogEntry logEntry, String? id) {
    return _records
        .doc(id)
        .update({
          'dateTime': logEntry.dateTime,
          'mealType': logEntry.mealType,
          'glucoseLevel': logEntry.glucoseLevel,
          'carbs': logEntry.carbs,
          'insulin': logEntry.insulin,
          'pill': logEntry.pill,
          'insulinType': logEntry.insulinType,
          'pillType': logEntry.pillType,
          'userId': logEntry.userId,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  static Future<List<LogEntry>> getLast10GlucoseRecords(
      String accountId) async {
    List<LogEntry> recordList = [];
    int count = 0;
    await _records
        .where("userId", isEqualTo: accountId)
        .orderBy("dateTime", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (count == 10) {
          break;
        }
        if (doc["glucoseLevel"] != null) {
          count++;
          LogEntry logEntry = LogEntry(
              dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
              glucoseLevel: doc["glucoseLevel"],
              userId: doc["userId"]);
          recordList.add(logEntry);
        }
      }
    }).catchError((error) {
      print(error);
    });
    return recordList;
  }

  static Future<List<LogEntry>> getLast10Records(String accountId) async {
    List<LogEntry> recordList = [];
    await _records
        .where("userId", isEqualTo: accountId)
        .orderBy("dateTime", descending: true)
        .limit(10)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        LogEntry logEntry = LogEntry(
            id: doc.id,
            dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
            glucoseLevel: doc["glucoseLevel"],
            carbs: doc["carbs"],
            insulin: doc["insulin"],
            pill: doc["pill"],
            insulinType: doc["insulinType"],
            pillType: doc["pillType"],
            mealType: doc["mealType"],
            userId: doc["userId"]);
        recordList.add(logEntry);
      }
    }).catchError((error) {
      print(error);
    });
    return recordList;
  }

  static Future<List<LogEntry>> getAllRecords(
      String accountId, bool descending) async {
    List<LogEntry> recordList = [];
    await _records
        .where("userId", isEqualTo: accountId)
        .orderBy("dateTime", descending: descending)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        LogEntry logEntry = LogEntry(
            id: doc.id,
            dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
            glucoseLevel: doc["glucoseLevel"],
            carbs: doc["carbs"],
            insulin: doc["insulin"],
            pill: doc["pill"],
            insulinType: doc["insulinType"],
            pillType: doc["pillType"],
            mealType: doc["mealType"],
            userId: doc["userId"]);
        recordList.add(logEntry);
      }
    }).catchError((error) {
      print(error);
    });
    return recordList;
  }

  static Future<bool> deleteRecord(String? id) {
    return _records
        .doc(id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  static Future<List<LogCount>> getRecordsCountByTimeFrame(
      String accountId) async {
    List<LogCount> recordList = [];
    bool isFinalGlucoseLog = false;
    DateTime now = DateTime.now();

    int currentDay = now.weekday;
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
    LogCount weeklyCount = LogCount(
        dateTime: null,
        index: 0,
        type: "weekly",
        inrange: 0,
        below: 0,
        above: 0);
    LogCount monthlyCount = LogCount(
        dateTime: null,
        index: 1,
        type: "monthly",
        inrange: 0,
        below: 0,
        above: 0);
    LogCount yearlyCount = LogCount(
        dateTime: null,
        index: 2,
        type: "yearly",
        inrange: 0,
        below: 0,
        above: 0);
    await _records
        .where("userId", isEqualTo: accountId)
        .orderBy("dateTime", descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["glucoseLevel"] != null && !isFinalGlucoseLog) {
          weeklyCount.dateTime =
              DateTime.parse(doc["dateTime"].toDate().toString());
          monthlyCount.dateTime =
              DateTime.parse(doc["dateTime"].toDate().toString());
          yearlyCount.dateTime =
              DateTime.parse(doc["dateTime"].toDate().toString());
          isFinalGlucoseLog = true;
        }
        if (DateTime.parse(doc["dateTime"].toDate().toString())
            .isAfter(Timestamp.fromDate(firstDayOfWeek).toDate())) {
          if (doc["glucoseLevel"] != null) {
            if (doc["glucoseLevel"] > 120) {
              weeklyCount.above += 1;
            } else if (doc["glucoseLevel"] > 70) {
              weeklyCount.inrange += 1;
            } else {
              weeklyCount.below += 1;
            }
          }
        }
        if (DateTime.parse(doc["dateTime"].toDate().toString()).isAfter(
            Timestamp.fromDate(DateTime(now.year, now.month, 1)).toDate())) {
          if (doc["glucoseLevel"] != null) {
            if (doc["glucoseLevel"] > 120) {
              monthlyCount.above += 1;
            } else if (doc["glucoseLevel"] > 70) {
              monthlyCount.inrange += 1;
            } else {
              monthlyCount.below += 1;
            }
          }
        }
        if (DateTime.parse(doc["dateTime"].toDate().toString())
            .isAfter(Timestamp.fromDate(DateTime(now.year, 1, 1)).toDate())) {
          if (doc["glucoseLevel"] != null) {
            if (doc["glucoseLevel"] > 120) {
              yearlyCount.above += 1;
            } else if (doc["glucoseLevel"] > 70) {
              yearlyCount.inrange += 1;
            } else {
              yearlyCount.below += 1;
            }
          }
        }
      });
      recordList.add(weeklyCount);
      recordList.add(monthlyCount);
      recordList.add(yearlyCount);
    }).catchError((error) {
      print(error);
    });
    return recordList;
  }

  static Future<List<LogEntry>> getRecordsByTimeFrame(
      String accountId, String period,
      {bool isDecending = true}) async {
    List<LogEntry> recordList = [];
    DateTime date = DateTime.now();

    if (period == "This week") {
      DateTime now = DateTime.now();
      int currentDay = now.weekday;
      DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
      await _records
          .where("userId", isEqualTo: accountId)
          .where("dateTime",
              isGreaterThanOrEqualTo: Timestamp.fromDate(firstDayOfWeek))
          .orderBy("dateTime", descending: isDecending)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          LogEntry account = LogEntry(
              id: doc.id,
              dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
              glucoseLevel: doc["glucoseLevel"],
              carbs: doc["carbs"],
              insulin: doc["insulin"],
              pill: doc["pill"],
              insulinType: doc["insulinType"],
              pillType: doc["pillType"],
              mealType: doc["mealType"],
              userId: doc["userId"]);
          recordList.add(account);
        });
      }).catchError((error) {
        print(error);
      });
    } else if (period == "This month") {
      DateTime now = DateTime.now();
      await _records
          .where("userId", isEqualTo: accountId)
          .where("dateTime",
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(DateTime(now.year, now.month, 1)))
          .orderBy("dateTime", descending: isDecending)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          LogEntry account = LogEntry(
              id: doc.id,
              dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
              glucoseLevel: doc["glucoseLevel"],
              carbs: doc["carbs"],
              insulin: doc["insulin"],
              pill: doc["pill"],
              insulinType: doc["insulinType"],
              pillType: doc["pillType"],
              mealType: doc["mealType"],
              userId: doc["userId"]);
          recordList.add(account);
        });
      }).catchError((error) {
        print(error);
      });
    } else if (period == "This year") {
      DateTime now = DateTime.now();
      await _records
          .where("userId", isEqualTo: accountId)
          .where("dateTime",
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(DateTime(now.year, 1, 1)))
          .orderBy("dateTime", descending: isDecending)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          LogEntry account = LogEntry(
              id: doc.id,
              dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
              glucoseLevel: doc["glucoseLevel"],
              carbs: doc["carbs"],
              insulin: doc["insulin"],
              pill: doc["pill"],
              insulinType: doc["insulinType"],
              pillType: doc["pillType"],
              mealType: doc["mealType"],
              userId: doc["userId"]);
          recordList.add(account);
        });
      }).catchError((error) {
        print(error);
      });
    } else if (period == "All records") {
      await _records
          .where("userId", isEqualTo: accountId)
          .orderBy("dateTime", descending: isDecending)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          LogEntry account = LogEntry(
              id: doc.id,
              dateTime: DateTime.parse(doc["dateTime"].toDate().toString()),
              glucoseLevel: doc["glucoseLevel"],
              carbs: doc["carbs"],
              insulin: doc["insulin"],
              pill: doc["pill"],
              insulinType: doc["insulinType"],
              pillType: doc["pillType"],
              mealType: doc["mealType"],
              userId: doc["userId"]);
          recordList.add(account);
        });
      }).catchError((error) {
        print(error);
      });
    }
    return recordList;
  }

  static Future<void> deleteDataByUser(String userId) async {
    var snapshot = await _records.where('userId', isEqualTo: userId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}

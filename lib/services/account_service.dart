import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabeta_app/model/account_info.dart';

class AccountService {
  static final CollectionReference _records =
      FirebaseFirestore.instance.collection('account_info');

  static Future<String> addRecord(AccountInfo accountInfo) {
    return _records.add({
      'uid': accountInfo.uid,
      'fullname': accountInfo.fullname,
      'email': accountInfo.email,
      'mobile': accountInfo.mobile,
      'diabetesType': accountInfo.diabetesType,
      'gender': accountInfo.gender,
      'dob': accountInfo.dob,
      'yod': accountInfo.yod
    }).then((value) {
      return value.id;
    }).catchError((error) {
      return "";
    });
  }

  static Future<bool> editRecord(AccountInfo accountInfo, String? id) {
    return _records
        .doc(id)
        .update({
          'fullname': accountInfo.fullname,
          'email': accountInfo.email,
          'mobile': accountInfo.mobile,
          'diabetesType': accountInfo.diabetesType,
          'gender': accountInfo.gender,
          'dob': accountInfo.dob,
          'yod': accountInfo.yod
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  static Future<AccountInfo> getAccountInfoByID(String id) async {
    AccountInfo accountInfo = new AccountInfo();
    await _records
        .where("uid", isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        accountInfo = AccountInfo(
          id: doc.id,
          uid: doc["uid"],
          dob: doc["dob"] !=null ? DateTime.parse(doc["dob"].toDate().toString()): null,
          yod: doc["yod"] != null ? DateTime.parse(doc["yod"].toDate().toString()): null,
          diabetesType: doc["diabetesType"],
          email: doc["email"],
          fullname: doc["fullname"],
          gender: doc["gender"],
          mobile: doc["mobile"],
        );
      });
    }).catchError((error) {
      print(error);
    });
    return accountInfo;
  }
}

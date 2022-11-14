import 'package:diabeta_app/components/constants.dart';
import 'package:flutter/material.dart';

class YesNoModel extends StatelessWidget {
  final Future<void> Function(BuildContext) callBack;
  final BuildContext buildContext;
  final String msg;

  const YesNoModel({ Key? key , required this.callBack, required this.msg, required this.buildContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirm Delete',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content:Container(
        //height: 50,
        child: Text(msg),
      ),
      actions: [
        TextButton(
          onPressed: (){
            callBack(buildContext);
            Navigator.pop(context);
          },
          child: const Text('YES',style: TextStyle(color: kPrimaryColor),),
        ),
        TextButton(
          onPressed: () => (Navigator.pop(context, false)),
          child: const Text('NO', style: TextStyle(color: kPrimaryColor),),
        ),
      ],
    );
  }
}
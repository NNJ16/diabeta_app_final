import 'package:flutter/material.dart';

class Bcard extends StatefulWidget {
  const Bcard({Key? key, required this.text, required this.iconData, required this.index, required this.selectedindex, required this.callback}) : super(key: key);
  final String text;
  final IconData iconData;
  final int index;
  final int selectedindex;
  final Function(int) callback;

  @override
  State<Bcard> createState() => _BcardState();
}

class _BcardState extends State<Bcard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        widget.callback(widget.index);
        FocusScope.of(context).requestFocus(FocusNode());
      }),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), color: widget.selectedindex == widget.index ? Colors.teal[100] : Colors.white,),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData,
                size: 30,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 10
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

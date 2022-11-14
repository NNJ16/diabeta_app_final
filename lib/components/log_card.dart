import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/model/log_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogCard extends StatefulWidget {
  const LogCard({Key? key, required this.logEntry}) : super(key: key);
  final LogEntry logEntry;

  @override
  State<LogCard> createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {
  int color = 0xFFff9d00;

  void _changeGlucoseColor(int glucose){
    if(glucose > 315){
      setState(() {
        color = 0xFFff0000;
      });
    }else if(glucose > 180){
      setState(() {
        color = 0xFFfa5c5c;
      });
    }else if(glucose > 120){
      setState(() {
        color = 0xFFff9d00;
      });
    }else if(glucose > 70){
      setState(() {
        color = 0xFF34eb43;
      });
    }else if(glucose > 0){
      setState(() {
        color = 0xFFff0000;
      });
    }
  }
  
  @override
  void initState(){
     if(widget.logEntry.glucoseLevel != null){
        _changeGlucoseColor(widget.logEntry.glucoseLevel!.toInt());
     }
    super.initState();
  }

  @override
  void didUpdateWidget(LogCard oldWidget) {
    super.didUpdateWidget(oldWidget);
     if(widget.logEntry.glucoseLevel != null){
        _changeGlucoseColor(widget.logEntry.glucoseLevel!.toInt());
     }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.teal[400]!))),
      child: Column(
        children: [
          Container(
            color: Colors.teal,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('MMMM dd, yyyy').format(widget.logEntry.dateTime),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1.5, color: Colors.grey[300]!))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Text(
                          DateFormat.jm().format(widget.logEntry.dateTime),
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widget.logEntry.glucoseLevel != null ?
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(color),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.logEntry.glucoseLevel!.toStringAsFixed(0),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'mg/dL',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    )
                  ],
                ),
              ):Container(),
              widget.logEntry.insulin != null ?
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: kSecondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.logEntry.insulin!.toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Units',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ): Container(),
              widget.logEntry.pill != null ?
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: kSecondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.logEntry.pill!.toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Units',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ): Container(),
              widget.logEntry.carbs != null ?
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.amber,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.logEntry.carbs!.toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'grams',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ): Container(),
              const SizedBox(
                width: 8,
              ),
              Icon(
                getMealIconByName(widget.logEntry.mealType!),
                size: 40,
                color: Colors.teal[300],
              )
            ],
          ),
        ],
      ),
    );
  }
}

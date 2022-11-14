import 'dart:typed_data';
import 'package:diabeta_app/services/glucose_log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintLogScreen extends StatelessWidget {
  PrintLogScreen({Key? key, required this.period}) : super(key: key);
  String period;
  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logbook")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    var list = await GlucoseLogService.getRecordsByTimeFrame(_currentUser!.uid, period);

    pdf.addPage(pw.MultiPage(
        pageFormat: format,
        maxPages: 20,
        build: (pw.Context context) {
          return getBarcodes(list);
        }));
    return pdf.save();
  }

  List<pw.Widget> getBarcodes(var list) {
    List<pw.Widget> barcodeList = [];
    barcodeList.add(pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(3),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(2),
        4: const pw.FlexColumnWidth(2),
        5: const pw.FlexColumnWidth(2),
      },
      border: pw.TableBorder.all(width: 1.0, color: PdfColors.teal),
      children: [
        pw.TableRow(children: [
          pw.Text(
            "Date",
            textScaleFactor: 1.5,
            textAlign: pw.TextAlign.center,
          ),
          pw.Text(
            "Time",
            textScaleFactor: 1.5,
            textAlign: pw.TextAlign.center,
          ),
          pw.Text("Glucose", textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
          pw.Text("Carbs",textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
          pw.Text("Insulin",textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
          pw.Text("Pill",textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
        ]),
      ],
    ));

    list.forEach((entry) => barcodeList.add(pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
            4: const pw.FlexColumnWidth(2),
            5: const pw.FlexColumnWidth(2),
          },
          border: pw.TableBorder.all(width: 1.0, color: PdfColors.teal),
          children: [
            pw.TableRow(children: [
              pw.Text(
                DateFormat('yyyy. MM. dd').format(entry.dateTime).toString(),
                textAlign: pw.TextAlign.center,
                textScaleFactor: 1.5,
              ),
              pw.Text(
                formatTimeOfDay(TimeOfDay.fromDateTime(entry.dateTime))
                    .toString(),
                    textAlign: pw.TextAlign.center,
                textScaleFactor: 1.5,
              ),
              pw.Text(entry.glucoseLevel == null ? "":entry.glucoseLevel.toString() ,textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
              pw.Text(entry.carbs == null ? "":entry.carbs.toString(),textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
              pw.Text(entry.insulin == null ? "":entry.insulin.toString(),textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
              pw.Text(entry.pill == null ? "":entry.pill.toString(),textAlign: pw.TextAlign.center, textScaleFactor: 1.5),
            ]),
          ],
        )));

    return barcodeList;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}

// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:diabeta_app/model/diabetes_ques_ans.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen1 extends StatelessWidget {
  const PrintScreen1(
      {Key? key,
      required this.comment,
      required this.prediction,
      required this.riskScore})
      : super(key: key);
  final String comment;
  final bool prediction;
  final double riskScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediction Result")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: double.infinity,
                color: PdfColors.teal100,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text("Prediabetes Prediction Result",
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Row(children: [
                pw.Text("1. " + DiabeticQuestions.sampleQuiz2[0].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[0].defaultValue == 1
                        ? "  Male"
                        : "  Female",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("2. " + DiabeticQuestions.sampleQuiz2[1].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    "  " +
                        DiabeticQuestions.sampleQuiz2[1].defaultValue
                            .toStringAsFixed(0) +
                        " years",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("3. " + DiabeticQuestions.sampleQuiz2[2].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[2].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 8),
              pw.Row(children: [
                pw.Text("4. " + DiabeticQuestions.sampleQuiz2[3].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[3].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),

              pw.Row(children: [
                pw.Text("5. " + DiabeticQuestions.sampleQuiz2[4].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[4].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("6. " + DiabeticQuestions.sampleQuiz2[5].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[5].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("7. " + DiabeticQuestions.sampleQuiz2[6].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[6].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("8. " + DiabeticQuestions.sampleQuiz2[7].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[7].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("9. " + DiabeticQuestions.sampleQuiz2[8].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[8].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 12),
              pw.Row(children: [
                pw.Text("10. " + DiabeticQuestions.sampleQuiz2[9].question,
                    style: const pw.TextStyle(fontSize: 18)),
                pw.Text(
                    DiabeticQuestions.sampleQuiz2[9].defaultValue == 1
                        ? "  Yes"
                        : "  No",
                    style: const pw.TextStyle(
                        fontSize: 18, color: PdfColors.teal)),
              ]),
              pw.SizedBox(height: 20),
              pw.Container(
                color: PdfColors.teal100,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Test Result",
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 8),
                      pw.Row(children: [
                        pw.Text("Diabetes Status : ",
                            style: const pw.TextStyle(
                              fontSize: 18,
                            )),
                        prediction
                            ? pw.Text("Positive",
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.red900))
                            : pw.Text("Negative",
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.green900))
                      ]),
                      pw.SizedBox(height: 4),
                      pw.Row(children: [
                        pw.Text("Risk Score : ",
                            style: const pw.TextStyle(
                              fontSize: 18,
                            )),
                        pw.Text(riskScore.toStringAsFixed(2) + "%",
                            style: const pw.TextStyle(
                              fontSize: 18,
                            ))
                      ]),
                      pw.SizedBox(height: 8),
                      pw.Text("Comment : ",
                          style: const pw.TextStyle(
                            fontSize: 18,
                          )),
                      pw.SizedBox(height: 4),
                      pw.Text(comment,
                          style: const pw.TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}

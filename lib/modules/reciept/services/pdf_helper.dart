import 'dart:typed_data';
import 'package:ayur_project/modules/login/models/booked_treatment_model.dart';
import 'package:ayur_project/modules/login/models/register_request_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../utils/utils.dart';

class PdfService {

  static Future<Uint8List> generateReceipt(RegisterRequestModel? request, List<BookedTreatmentModel> bookedTreatments) async {

    Future<pw.MemoryImage> loadImage(String path) async {
      final data = await rootBundle.load(path);
      return pw.MemoryImage(data.buffer.asUint8List());
    }
    final logo = await loadImage('assets/pngs/app_logo.png');
    final signature = await loadImage('assets/pngs/signature.png');
    final logoBg = await loadImage('assets/pngs/logo_bg.png');

    final fontData = await rootBundle.load('assets/fonts/Poppins-Regular.ttf');
    final font = pw.Font.ttf(fontData);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 10),
        build: (context) => pw.Stack(
          children: [
            pw.Center(child: pw.Image(logoBg, width: 450),),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _renderHeader(logo),
                pw.Divider(color: PdfColors.grey, height: 35),

                pw.Text('Patient Details', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
                pw.SizedBox(height: 10),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                        width: context.page.pageFormat.availableWidth / 3,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Name:'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Address:'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('WhatsApp Number: '),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('${request?.name}', style: pw.TextStyle(color: PdfColors.grey)),
                                  pw.SizedBox(height: 5),
                                  pw.Text('${request?.executive}', style: pw.TextStyle(color: PdfColors.grey)),
                                  pw.SizedBox(height: 5),
                                  pw.Text('+91${request?.phone}', style: pw.TextStyle(color: PdfColors.grey)),
                                ],
                              ),
                            ]
                        )
                    ),
                    pw.SizedBox(
                        width: context.page.pageFormat.availableWidth / 3,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Booked On: '),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Treatment Date: '),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Treatment Time: '),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('${Utils.formatDate(DateTime.now().toString())}', style: pw.TextStyle(color: PdfColors.grey)),
                                  pw.SizedBox(height: 5),
                                  pw.Text('${request?.dateAndTime.split("-").first}', style: pw.TextStyle(color: PdfColors.grey)),
                                  pw.SizedBox(height: 5),
                                  pw.Text('${request?.dateAndTime.split("-").last}', style: pw.TextStyle(color: PdfColors.grey)),
                                ],
                              ),
                            ]
                        )
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                _buildDottedDivider(),

                pw.SizedBox(height: 20),
                ..._renderTabularData(bookedTreatments, font),
                pw.SizedBox(height: 20),

                _buildDottedDivider(),

                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Total Amount: ₹${request?.totalAmount}', style: pw.TextStyle(font: font, fontSize: 13),),
                        pw.Text('Discount: ₹${request?.totalAmount}', style: pw.TextStyle(font: font, fontSize: 13),),
                        pw.Text('Advance: ₹${request?.totalAmount}',style: pw.TextStyle(font: font, fontSize: 13),),
                        pw.Text('Balance: ₹${request?.totalAmount}', style: pw.TextStyle(font: font, fontSize: 13),),
                      ],
                    )
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Align(
                  alignment: pw.AlignmentDirectional.centerEnd,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Thank you for choosing us',
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.green),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                            "our well-being is our commitment, and we're honored\nyou've entrusted us with your health journey",
                            textAlign: pw.TextAlign.end,
                            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey)
                        ),
                        pw.SizedBox(height: 20),
                        pw.Image(signature, width: 150),
                      ]
                  ),
                ),

                pw.SizedBox(height: 150),
                _buildDottedDivider(),
                pw.SizedBox(height: 10),
                pw.Text(
                    "''Booking amount is non-refundable, and it's important to arrive on the allotted time for your treatment''",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.grey)
                ),
              ],
            )
          ]
        ),
      ),
    );
    return pdf.save();
  }

  static _renderHeader(pw.ImageProvider logo){
    return pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Image(logo, width: 100),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'KUMARAKOM',
                style: pw.TextStyle(
                  fontSize: 18,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                  "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563\ne-mail: unknown@gmail.com\nMob: +91 9876543210 | +91 9786543210",
                  style: pw.TextStyle(fontSize: 13, color: PdfColors.grey,),
                  textAlign: pw.TextAlign.end
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'GST No: 32AABCU9603R1ZW',
                style: pw.TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          )
        ]
    );
  }

  static _renderTabularData(List<BookedTreatmentModel> bookedTreatments, pw.Font? font) {
    final List<String> headers = [
      'Treatment                            ',
      'Price',
      'Male',
      'Female',
      'Total'
    ];
    return [pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: List.generate(headers.length, (index) {
          return pw.Text(headers[index],
              style: pw.TextStyle(fontSize: 13, color: PdfColors.green));
        })
    ),
      pw.ListView.separated(itemCount: bookedTreatments.length, itemBuilder: (context, index) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("${bookedTreatments[index].treatments?.name}"),
            pw.Text("₹${bookedTreatments[index].treatments?.price}", style: pw.TextStyle(font: font)),
            pw.Text("${bookedTreatments[index].maleCount}"),
            pw.Text("${bookedTreatments[index].femaleCount}"),
            pw.Text("${((bookedTreatments[index].maleCount ?? 0) + (bookedTreatments[index].femaleCount ?? 0))}"),
          ]
        );
      }, separatorBuilder: (pw.Context context, int index) { return pw.SizedBox(height: 20); },)
    ];
  }

  static _buildDottedDivider(){
    return pw.Row(
      children: List.generate(40, (index) => pw.Container(
        width: 9,
        height: 1.5,
        color: PdfColors.grey.shade(0.1),
        margin: const pw.EdgeInsets.symmetric(horizontal: 2),
      ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<Uint8List> generateReceipt() async {

    Future<pw.MemoryImage> loadImage(String path) async {
      final data = await rootBundle.load(path);
      return pw.MemoryImage(data.buffer.asUint8List());
    }
    final logo = await loadImage('assets/pngs/app_logo.png');
    final signature = await loadImage('assets/pngs/signature.png');
    final logoBg = await loadImage('assets/pngs/logo_bg.png');

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
                                  pw.Text('Salih'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Kumarkom'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('+91 9876543210'),
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
                                  pw.Text('Booked On:'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Treatment Date:'),
                                  pw.SizedBox(height: 5),
                                  pw.Text('Treatment Time:'),
                                ],
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('31/01/2024'),
                                  pw.SizedBox(height: 5),
                                  pw.Text(' 21/02/2024'),
                                  pw.SizedBox(height: 5),
                                  pw.Text(' 11:00 am'),
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
                pw.TableHelper.fromTextArray(
                  headers: ['Treatment', 'Price', 'Male', 'Female', 'Total'],
                  data: [
                    ['Panchakarma', '₹230', '4', '4', '₹2,540'],
                    ['Njavara Kizhi Treatment', '₹230', '4', '4', '₹2,540'],
                    ['Panchakarma', '₹230', '4', '6', '₹2,540'],
                  ],
                ),
                pw.SizedBox(height: 20),

                _buildDottedDivider(),

                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Total Amount: ₹7,620'),
                        pw.Text('Discount: ₹500'),
                        pw.Text('Advance: ₹1,200'),
                        pw.Text('Balance: ₹5,920'),
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

  static _buildDottedDivider(){
    return pw.Row(
      children: List.generate(37, (index) => pw.Container(
        width: 9,
        height: 1.5,
        color: PdfColors.grey.shade(0.1),
        margin: const pw.EdgeInsets.symmetric(horizontal: 2),
      ),
      ),
    );
  }
}

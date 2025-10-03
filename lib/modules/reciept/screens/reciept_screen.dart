import 'package:ayur_project/constants/app_colors.dart';
import 'package:ayur_project/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../services/pdf_helper.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          leading: Icon(Icons.arrow_back, color: AppColors.white,),
          backgroundColor: AppColors.primary,
          title:
          Text('Receipt',
              style: AppTextStyles.poppinsMedium(18, color: AppColors.white)
          )
      ),
      body: PdfPreview(
        pdfPreviewPageDecoration: BoxDecoration(
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 80),
        build: (format) async => await PdfService.generateReceipt(),
        allowPrinting: true,
        allowSharing: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        actionBarTheme: PdfActionBarTheme(
          backgroundColor: AppColors.primary
        ),
      ),
    );
  }
}
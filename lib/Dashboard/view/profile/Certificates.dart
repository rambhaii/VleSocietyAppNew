import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlesociety/Dashboard/view/profile/Downlode_Certificates.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../controller/DashboardController.dart';
import 'package:dio/dio.dart';

import 'DownLoad.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class YourCertificates extends StatefulWidget {
  const YourCertificates({Key? key}) : super(key: key);

  @override
  State<YourCertificates> createState() => _YourCertificatesState();
}

class _YourCertificatesState extends State<YourCertificates> {
  DashboardController controller = Get.find();






  @override
  Widget build(BuildContext context)
  {
    controller.getCertificateListNetworkApi();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Downlode Certificates",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Congratulations ! You have earned 1 Certificatess",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 10, color: Colors.black),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.16,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => controller.certificateModel.value.data != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.certificateModel.value.data!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index)
                            {
                              final data=controller.certificateModel.value.data![index];
                              return Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: 50,
                                      child: Icon(Icons.star),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width /
                                          1.235,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Certificate of Participation",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                   data.title.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .grey.shade700),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              IconButton(
                                                onPressed: () async
                                                {
                                                  final urlPreview =BASE_URL+data.certificate.toString();
                                                  final url = Uri.parse(urlPreview);
                                                  final response = await http.get(url);
                                                  final bytes = response.bodyBytes;
                                                  final temp = await getTemporaryDirectory();
                                                  final path = '${temp.path}/image.pdf';
                                                  File(path).writeAsBytesSync(bytes);
                                                  await Share.shareFiles([path], text: data.title.toString());
                                                },
                                                icon: Icon(
                                                  Icons.share_sharp,
                                                  size: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text("issued on ${data.addDate}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                  onTap: ()
                                                {
                                                 // generatePdf(BASE_URL+data.certificate.toString());
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => const DownloadingDialog(),
                                                    );
                                                },
                                                  child: Text(
                                                    "DOWNLODE",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                        : Container()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  Future<Uint8List> _generatePdf(PdfPageFormat format, String title,String imageUrl)
  async {
    const String url = 'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';


    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(

      pw.Page(

        pageFormat: format,
        build: (context)
        {
          return pw.Column(
            children:
            [
              pw.SizedBox
                (
                width: double.infinity,
                child: pw.FittedBox
                  (
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

 void generatePdf(String imageUrl)async
  {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title,imageUrl));
  }
}
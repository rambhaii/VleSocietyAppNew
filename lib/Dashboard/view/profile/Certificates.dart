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
                                                    "Participation in vle society",
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
                                                async
                                                {
                                                 // generatePdf(context,data.certificate.toString());
                                                 /* showDialog(
                                                    context: context,
                                                    builder: (context) =>  DownloadingDialog(BASE_URL+data.certificate.toString()),
                                                    );*/

                                                  final urlPreview =BASE_URL+data.certificate.toString();
                                                  final url = Uri.parse(urlPreview);
                                                  final response = await http.get(url);



                                                  var data1 = await http.get(url);
                                                  final output = await getTemporaryDirectory();
                                                  final file = File('${output.path}/certificate${new DateTime.now().
                                                  microsecondsSinceEpoch}.pdf');
                                                  await file.writeAsBytes(data1.bodyBytes);
                                                  var pdfData = response.bodyBytes;
                                                  await Printing.layoutPdf(onLayout: (PdfPageFormat
                                                  format) async => pdfData);
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



  Future<Uint8List> buildPdf(PdfPageFormat format,String imageUrl,BuildContext context1,String images)
  async
  {
    String fileimage=BASE_URL+images.toString();
    print("dfghuhhjgk"+fileimage);

    final pdf = pw.Document();
    final image = await flutterImageProvider(NetworkImage(fileimage)
    );



    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (context)
            {
              return
              pw.Padding(
                padding: pw.EdgeInsets.only(right: 10,) ,
                child:  pw.Container(
                  height: MediaQuery.of(context1).size.height,
                  width: MediaQuery.of(context1).size.width,
                  child: pw.Row(
                    children:
                    [
                      pw.Image(image,fit:pw.BoxFit.cover),
                    ],
                  ),
                )
              );
               
            }
        ));
    return pdf.save();
  }






  void generatePdf(BuildContext context,String image) async {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => buildPdf(format, title,context,image));
  }

  Future<Uint8List> _generatxcvvePdf(PdfPageFormat format, AsyncSnapshot snapshot,
      BuildContext context, int index) async {
    final pdf = pw.Document();

    final image = await flutterImageProvider(NetworkImage(snapshot.data[index].img));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return
                pw.Container(
                height: 50,
                width: 50,
                child: pw.Row(
                  children:
                  [
                    pw.Image(image),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    return pdf.save();
  }
}

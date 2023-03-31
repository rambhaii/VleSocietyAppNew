import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:vlesociety/Dashboard/view/profile/Downlode_Certificates.dart';
class YourCertificates extends StatefulWidget {
  const YourCertificates({Key? key}) : super(key: key);

  @override
  State<YourCertificates> createState() => _YourCertificatesState();
}

class _YourCertificatesState extends State<YourCertificates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Downlode Certificates",style: TextStyle(color: Colors.black,fontSize:17,
                fontWeight: FontWeight.bold),),SizedBox(height: 4.h,),
            Text("Congratulations ! You have earned 1 Certificatess",overflow: TextOverflow.ellipsis,maxLines: 1,
              style: TextStyle(fontSize: 10,color: Colors.black),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/1.16,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: ScrollPhysics(),
                        itemBuilder:
                            (context,index){
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
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width/1.235,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Certificate of Participation"
                                                ,maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(
                                                    fontWeight: FontWeight.bold
                                                ),),SizedBox(height: 4,),
                                              Text("For completion of EAE",style: TextStyle(fontSize: 13,
                                                  color: Colors.grey.shade700),)
                                            ],
                                          ),
                                          Spacer(),
                                          IconButton(onPressed: (){},icon: Icon(Icons.share_sharp,size: 18,),)
                                        ],
                                      ),SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text("issued on 17-05-2022",style: TextStyle(fontSize: 12,
                                              color: Colors.grey),),
                                          Spacer(),
                                          InkWell(
                                              onTap: generatePdf,
                                              child: Text("DOWNLODE",style: TextStyle(color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold),))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _convertPdfToImages(pw.Document doc) async {
    await for (var page in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage();
      print(image);
    }
  }
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
  void generatePdf() async {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }
}
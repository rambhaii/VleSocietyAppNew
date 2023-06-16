import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';

import '../../controller/quize_controller.dart';
import '../dashboard.dart';
import 'QuestionHistory.dart';

class showresult extends StatefulWidget {
  final String ttCorrect;
  final String ttInCorrect;
  final String quize_id;
  final List<String> selectedAnsList;

  const showresult(this.selectedAnsList,
      {Key? key, required this.ttCorrect, required this.ttInCorrect, required this.quize_id})
      : super(key: key);

  @override
  State<showresult> createState() => _showresultState();
}

class _showresultState extends State<showresult> {
  late QuizeController controller;

  @override
  void initState() {
    controller = Get.put(QuizeController(quizeId: widget.quize_id));
    controller.getQuizqNetworkApi();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("dsjghkdjfmjdjfh" + widget.quize_id);
    return Scaffold(

      body: Stack(
        children: [
          Positioned(
              top: -60,
              right: 50,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffcdf55a),

                ),
              )
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Center(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Congratulations!",
                        style: subtitleStyle.copyWith(fontSize: 26)),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height / 10,),
                    Text(
                      "You have successfully completed", style: subtitleStyle,),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.check, color: Colors.green.shade600,
                                    size: 19),
                                Text(" ${widget.ttCorrect} Correct",
                                  style: smallTextStyle,),
                              ],
                            ), style: ButtonStyle(padding: MaterialStateProperty
                                .all(EdgeInsets.all(8)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade200),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),),
                            )),
                        SizedBox(width: 20,),
                        TextButton(onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.close, color: Colors.red, size: 19,),
                                Text(" ${widget.ttInCorrect} Incorrect",
                                  style: smallTextStyle,),
                              ],
                            ), style: ButtonStyle(padding: MaterialStateProperty
                                .all(EdgeInsets.all(8)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade200),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(
                              color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4))
                      ),
                      onPressed: ()
                      async {
                      /*  Printing.layoutPdf(
                          // [onLayout] will be called multiple times
                          // when the user changes the printer or printer settings
                            onLayout: (PdfPageFormat format)
                            {
                              // Any valid Pdf document can be returned here as a list of int
                              return buildPdf(format);
                            }
                        );
                        var value=generatePdf();*/
                        {
                          // Create the Pdf document
                          final pw.Document doc = pw.Document();
                          final directory = await getTemporaryDirectory();
                          final file = File('${directory.path}/MyResult.pdf');

                         /* doc.addPage(
                            pw.MultiPage(

                              margin: const pw.EdgeInsets.all(10),
                              pageFormat: PdfPageFormat.a4,
                              orientation: pw.PageOrientation.portrait,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,

                              build: (pw.Context context)
                              {
                                return <pw.Widget>
                                [
                                pw.Wrap(

                                    children: [

                                      pw.Container(
                                          margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
                                          child: pw.Row(
                                              children: [
                                                pw.Text("Name : ${GetStorage().read(AppConstant.userName) }"+  +"Total correct Answer : ${widget.ttCorrect}"+"  "+"Total Incorrect Answer :  ${widget.ttInCorrect}"),
                                                pw.SizedBox(width: 10),
                                                pw.Text("Total correct Answer : ${widget.ttCorrect}"),
                                                pw.SizedBox(width: 10),
                                                pw.Text("Total Incorrect Answer :  ${widget.ttInCorrect}")
                                              ]
                                          )
                                      ),

                                      pw.ListView.builder(itemBuilder: (context,index)
                                      {
                                        final data= controller.quizqModel.value.data!.questionList![index];
                                        return pw.
                                        Container(
                                          margin: pw.EdgeInsets.only(left: 15,right: 15,top: 10),
                                          child: pw.Column
                                            (

                                            children:
                                            [

                                              pw.Padding
                                                (

                                                  padding: pw.EdgeInsets.only(right: 0),
                                                  child:pw.Text("Q.${index+1} "+data.question.toString(),textAlign: pw.TextAlign.center,style: pw.TextStyle(
                                                      color: PdfColors.tealAccent400,
                                                      fontSize: 16,
                                                      letterSpacing: 1.5,height: 1.2
                                                  ))
                                              ),
                                              pw.SizedBox(height: 10,),
                                              pw.Padding(
                                                padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 5),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                  children:
                                                  [
                                                    pw.Text("1. "+data.optA.toString(),style: pw.TextStyle(color:data.answer.toString().contains("A")
                                                        ?PdfColors.green:PdfColors.black,
                                                        fontSize: 16
                                                    ) ),
                                                    pw.Text("2. "+data.optB.toString(),style: pw.TextStyle(color:data.answer.toString().contains("B")
                                                        ?PdfColors.green:PdfColors.black,
                                                        fontSize: 16
                                                    )
                                                    ),
                                                    pw.Text("3. "+data.optC.toString(),style: pw.TextStyle(color:data.answer.toString().contains("C")
                                                        ?PdfColors.green:PdfColors.black,
                                                        fontSize: 16
                                                    ) ),
                                                    pw.Text("4. "+data.optD.toString(),style: pw.TextStyle(color:data.answer.toString().contains("D")
                                                        ?PdfColors.green:PdfColors.black,
                                                        fontSize: 16
                                                    ) ),



                                                  ],
                                                ),


                                              )


                                            ],
                                          ),
                                        );
                                      },
                                          itemCount: controller.quizqModel.value.data!.questionList!.length

                                      )
                                    ]
                                ),
                                 ];

                              },
                            ),
                          );*/
                          /*
                          await file.writeAsBytes(await doc.save());

                      await Share.shareFiles(
                      [file.path],
                      text: 'Check out my goal details',
                      subject: 'My goal details',
                      );*/
                          doc.addPage(
                            pw.MultiPage(
                              pageFormat: PdfPageFormat.a4,
                              orientation: pw.PageOrientation.portrait,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              build: (pw.Context context)
                              {
                                return <pw.Widget>
                                [
                                  pw.Wrap(
                                    children: <pw.Widget>[
                                      pw.Header(text: "Name :${GetStorage().read(AppConstant.userName) }"
                                      ),
                                      pw.Container(

                                        width: PdfPageFormat.a4.width,
                                        child: pw.Row(
                                          mainAxisSize: pw.MainAxisSize.min,
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          children: <pw.Widget>[



                                            pw.Expanded(
                                              child: pw.Column(
                                                mainAxisSize: pw.MainAxisSize.min,
                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                children: <pw.Widget>[
                                                  pw.SizedBox(height: 8.0),
                                                  for (int i = 0; i < controller.quizqModel.value.data!.questionList!.length; i++)
                                                    pw.Column(
                                                      mainAxisSize: pw.MainAxisSize.min,
                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                      children: <pw.Widget>[
                                                        pw.Padding
                                                          (

                                                            padding: pw.EdgeInsets.only(right: 0),
                                                            child:pw.Text("${i+1} "+controller.quizqModel.value.data!.questionList![i].question.toString(),style: pw.TextStyle(
                                                                color: PdfColors.black,
                                                                fontSize: 16,
                                                                letterSpacing: 1.5,height: 1.2
                                                            ))
                                                        ),
                                                        pw.SizedBox(height: 1,),
                                                        pw.Padding(
                                                          padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 0),
                                                          child: pw.Column(
                                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                            children:
                                                            [
                                                              pw.Text("1. "+controller.quizqModel.value.data!.questionList![i].optA.toString(),
                                                                  style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("A")
                                                                      ?PdfColors.green:PdfColors.black,
                                                                      fontSize: 10
                                                                  ) ),
                                                              pw.Text("2. "+controller.quizqModel.value.data!.questionList![i].optB.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("B")
                                                                  ?PdfColors.green:PdfColors.black,
                                                                  fontSize: 10
                                                              )
                                                              ),


                                                              pw.Text("3. "+controller.quizqModel.value.data!.questionList![i].optC.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("C")
                                                                  ?PdfColors.green:PdfColors.black,
                                                                  fontSize: 10
                                                              ) ),
                                                              pw.Text("4. "+controller.quizqModel.value.data!.questionList![i].optD.toString(),style: pw.TextStyle(color:controller.quizqModel.value.data!.questionList![i].answer.toString().contains("D")
                                                                  ?PdfColors.green:PdfColors.black,
                                                                  fontSize: 10
                                                              )
                                                              ),



                                                            ],
                                                          ),


                                                        )



                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ];
                              },
                            ),
                          );

                          await file.writeAsBytes(await doc.save());

                          await Share.shareFiles(
                            [file.path],
                            text: 'Check out my goal details',
                            subject: 'My goal details',
                          );



                      }


                      }
                      , child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Share Result", style: subtitleStyle,),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(
                              color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4))
                      ),
                      onPressed: () {
                        print("jkdsfhhjg" + widget.selectedAnsList.toString());
                        Get.to(QuestionHistory(widget.quize_id, widget
                            .selectedAnsList));
                      }, child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Show Result",
                            style: subtitleStyle.copyWith(
                                fontWeight: FontWeight.w400),),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(
                              color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4))
                      ),
                      onPressed: ()
                      {
                        Get.off(HomeDashboard());

                      }, child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Attempt New Quiz",
                            style: subtitleStyle.copyWith(
                                fontWeight: FontWeight.w400),),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Lottie.asset('assets/json/confetti.json',
                repeat: false,
                frameRate: FrameRate.max
                , fit: BoxFit.fill),
          )
        ],
      ),
    );
  }

 Future<dynamic>  generatePdf()async
  {

    var result = await Printing.layoutPdf(onLayout: (format) => buildPdf(format));
    return result;
  }


  Future<Uint8List> buildPdf(PdfPageFormat format) async
  {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/my_goal.pdf');

    doc.addPage(
      pw.Page(

        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context)
        {
          return pw.Column(

            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Container(
                  margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
                child: pw.Row(
                  children: [
                       pw.Text("Name : ${"Uday"}"),
                       pw.SizedBox(width: 10),
                       pw.Text("Total correct Answer : ${widget.ttCorrect}"),
                       pw.SizedBox(width: 10),
                       pw.Text("Total Incorrect Answer :  ${widget.ttInCorrect}")
                  ]
                )
              ),

          pw.ListView.builder(itemBuilder: (context,index)
          {
            final data= controller.quizqModel.value.data!.questionList![index];
            return pw.
            Container(
              margin: pw.EdgeInsets.only(left: 15,right: 15,top: 20),
              child: pw.Column
                (

                children:
                [

                  pw.Padding
                    (

                      padding: pw.EdgeInsets.only(right: 0),
                      child:pw.Text("Q.${index+1} "+data.question.toString(),textAlign: pw.TextAlign.center,style: pw.TextStyle(
                        color: PdfColors.tealAccent400,
                        fontSize: 16,
                         letterSpacing: 1.5,height: 1.2
                      ))
                     ),
                     pw.SizedBox(height: 10,),
                    pw.Padding(
                      padding:pw.EdgeInsets.only(left: 0,top: 0,bottom: 5),
                    child: pw.Column(
                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children:
                      [
                        pw.Text("1. "+data.optA.toString(),style: pw.TextStyle(color:data.answer.toString().contains("A")
                            ?PdfColors.green:PdfColors.black,
                            fontSize: 16
                          ) ),
                        pw.Text("2. "+data.optB.toString(),style: pw.TextStyle(color:data.answer.toString().contains("B")
                            ?PdfColors.green:PdfColors.black,
                          fontSize: 16
                        )
                        ),
                        pw.Text("3. "+data.optC.toString(),style: pw.TextStyle(color:data.answer.toString().contains("C")
                            ?PdfColors.green:PdfColors.black,
                            fontSize: 16
                        ) ),
                        pw.Text("4. "+data.optD.toString(),style: pw.TextStyle(color:data.answer.toString().contains("D")
                            ?PdfColors.green:PdfColors.black,
                            fontSize: 16
                        ) ),



                      ],
                    ),


                  )


                ],
              ),
            );
          },
          itemCount: controller.quizqModel.value.data!.questionList!.length

        )
            ]
          );



        },
      ),
    );
    await file.writeAsBytes(await doc.save());

    await Share.shareFiles(
      [file.path],
      text: 'Check out my goal details',
      subject: 'My goal details',
    );



    return await doc.save();
    }
    }

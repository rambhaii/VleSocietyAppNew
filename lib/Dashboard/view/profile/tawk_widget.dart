import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../AppConstant/textStyle.dart';
import 'tawk_visitor.dart';


class ChatAd extends StatefulWidget
{
  final String directChatLink;
  final String title;
  final Function? onLoad;
  final Function(String)? onLinkTap;
  final Widget? placeholder;

  const ChatAd({
    Key? key,
    required this.directChatLink,
    required this.title,
    this.onLoad,
    this.onLinkTap,
    this.placeholder,
  }) : super(key: key);

  @override
  _TawkState createState() => _TawkState();
}

class _TawkState extends State<ChatAd>
{
 // late WebViewController _controller;
   Completer<WebViewController> _controller =
  Completer<WebViewController>();
  late WebViewController _con;

  /*String setHTML(String email, String phone, String name)
  {
    return ('''
    <html>
      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      </head>
      
        <body style="background-color:#fff;height:100vh ">

          <div style="width: 50%; margin: 0 auto;margin-top: 200px">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th>Name</th>
                  <th>$name</th>
                </tr>
                <tr>
                  <th>Email</th>
                  <td>$email</td>
                </tr>
                <tr>
                  <th>Phone</th>
                  <th>$phone</th>
                </tr>
              </tbody>
            </table>
            <a type="button" class="btn btn-success" style="width: 210px" href="https://connelevalsam.github.io/connelblaze/">
              Submit
            </a>
          </div>
        </body>
      </html>
      

    ''');
  }

  _loadHTML() async {
    _con.loadUrl(Uri.dataFromString(
        setHTML(
            "connelblaze@gmil.com",
            "+2347034857296",
            "Connel Asikong"
        ),
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }*/


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        appBar:PreferredSize(
          child: Stack(
              children: [
                Positioned(
                    top: -80,
                    right: 60,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:   Color(0xffcdf55a),

                      ),
                    )
                ),
                ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: AppBar(
                          backgroundColor: Colors.white.withOpacity(0.5),
                          leading: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(

                            ),
                            child: IconButton(
                              onPressed:()=> Navigator.of(context).pop(),
                              icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
                          ),
                          elevation: 0.0,
                          leadingWidth: 60,
                          title: widget.title!=null?
                          Text( widget.title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
                          ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
                          ),
                        )
                    )
                )

              ]
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
      body:
      Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.directChatLink,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // _controller.complete(webViewController);
            _con = webViewController;
            //_loadHTML();
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(widget.directChatLink)) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }




  /* Stack(
        children:
        [
          WebView(
            initialUrl: widget.directChatLink,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController)
            {
              setState(()
              {
                _controller = webViewController;
              });
            },
            navigationDelegate: (NavigationRequest request)
            {
              if (request.url == 'about:blank' || request.url.contains('tawk.to'))
              {
                return NavigationDecision.navigate;
              }

              if (widget.onLinkTap != null) {
                widget.onLinkTap!(request.url);
              }

              return NavigationDecision.prevent;
            },

          ),

        ],
      )*/


  }


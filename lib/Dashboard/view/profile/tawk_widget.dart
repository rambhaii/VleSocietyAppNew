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
        return
          WebView(
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


import 'dart:async';
import 'package:devtools/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsViews extends StatefulWidget {
  final String url;
  const NewsViews({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<NewsViews> createState() => _NewsViewsState();
}

class _NewsViewsState extends State<NewsViews> {
  final Completer<WebViewController> completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0.0, backgroundColor: MyTheme.creamColor),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(top: 10, left: 10, bottom: 20, right: 10),
            child: WebView(
              initialUrl: widget.url,
              onWebViewCreated: ((WebViewController webViewController) {
                completer.complete(webViewController);
              }),
            )),
      ),
    );
  }
}

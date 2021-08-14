import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class TermConditionScreen extends StatefulWidget {

  @override
  _TermConditionScreenState createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: (){}, child: Icon(Icons.close,color: Colors.white,)),
        title: Text("Term & Conditions"),
        actions: [
          TextButton(onPressed: (){}, child: Text("Agree",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://myapp-notify.web.app/',
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}

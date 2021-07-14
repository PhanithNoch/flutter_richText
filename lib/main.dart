import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as richText;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Input / Output
  This library uses Quill as an internal data format.
  Use _controller.document.toDelta() to extract the deltas.
  Use _controller.document.toPlainText() to extract plain text.
   */
 final richText.QuillController _controller = richText.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rich Text FLutter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            richText.QuillToolbar.basic(controller: _controller),
            Expanded(
              child: Container(
                child: richText.QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            TextButton(onPressed: (){
              setState(() {

              });
            }, child: Text("Load")),
            Expanded(child: Text(_controller.document.toPlainText())),
          ],
        ),
      ),
    );
  }
}


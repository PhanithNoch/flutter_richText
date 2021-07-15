import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as richText;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
  // richText.QuillController _controller = richText.QuillController.basic();
  late richText.QuillController _controller;
  CollectionReference users = FirebaseFirestore.instance.collection('editors');
  var myJSON;

  @override
  void initState() {
    users.get().then((value) {
      myJSON = jsonDecode(value.docs[0]['text']);
      _controller = richText.QuillController(
          document: richText.Document.fromJson(myJSON),
          selection: TextSelection.collapsed(offset: 0));
    });

    super.initState();
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
        child: Padding(
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

              TextButton(
                onPressed: () {
                  var json = jsonEncode(_controller.document.toDelta().toJson());

                  addUser(json);
                },
                child: Text("Add Text To db"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser(var text) async {
    users
        .add({
          'text': text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

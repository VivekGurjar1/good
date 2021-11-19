import 'package:flutter/material.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({Key? key}) : super(key: key);

  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        centerTitle: true,
      ),

      body: Container(),
    );
  }
}

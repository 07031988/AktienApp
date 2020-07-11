import 'package:AktienApp/Models/Depot.dart';
import 'package:flutter/material.dart';

class NewDepotView extends StatelessWidget {
  Depot depot;
  NewDepotView({Key key, @required this.depot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = depot.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Depot "),
      ),
      body: Center(
        child: Column(
          
        ),
      ),
    );
  }
}

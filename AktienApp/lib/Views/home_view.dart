import 'package:AktienApp/Models/Depot.dart';
import 'package:AktienApp/Views/Aktien_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class HomeView extends StatelessWidget {
  final List<Depot> depotList = [
    Depot("Test", DateTime.now()),
    Depot("Mogen", DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ListView.builder(
            itemCount: depotList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildDepotCard(context, index)),
      ),
    );
  }

  Widget buildDepotCard(BuildContext context, int index) {
    final depot = depotList[index];
    return Container(
      child: GestureDetector(
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  depot.title,
                  style: TextStyle(fontSize: 30.0),
                ),
                Spacer(),
                Text(
                    "StartDate: ${DateFormat('dd.MM.yyyy').format(depot.startDate).toString()}")
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AktienView()));
        },
      ),
    );
  }
}

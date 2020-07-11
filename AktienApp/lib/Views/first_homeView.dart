import 'package:AktienApp/global.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class FirstView extends StatelessWidget {
  final primaryColor = darkGreyColor;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.10,
              ),
              Text("Welcome", style: redBoldText),
              SizedBox(
                height: _height * 0.10,
              ),
              AutoSizeText(
                "Let's create your Depot for your analyse ",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: redText,
              ),
              SizedBox(
                height: _height * 0.10,
              ),
              RaisedButton(
                color: redColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text(
                    "Get Started ",
                    style: darkTodoTitle,
                  ),
                ),
                onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signUp');
                },
              ),
              SizedBox(height: _height * 0.10),
              FlatButton(
                child: Text(
                  "Sign In",
                  style: bigLightBlueTitle,
                ),
                onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

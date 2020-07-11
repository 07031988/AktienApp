import 'package:AktienApp/Services/auth_service.dart';
import 'package:AktienApp/Services/provider.dart';
import 'package:AktienApp/Views/first_homeView.dart';
import 'package:AktienApp/Views/sign_In_up_View.dart';
import 'package:AktienApp/global.dart';
import 'package:AktienApp/home_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
          auth: AuthService(),
          child: MaterialApp(
          title: "Aktien App",
          theme: ThemeData(
            primaryColor: darkGreyColor,
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) =>
                SignUpInView(authFormType: AuthFormType.signUp),
            '/signIn': (BuildContext context) =>
                SignUpInView(authFormType: AuthFormType.signIn),
            '/home': (BuildContext context) => Home(),
          }),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStatechanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return signedIn ? Home() : FirstView();
          }
          return CircularProgressIndicator();
        });
  }
}

import 'package:AktienApp/Services/provider.dart';
import 'package:AktienApp/global.dart';
import 'package:AktienApp/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:progress_indicators/progress_indicators.dart';

enum AuthFormType { signIn, signUp }
ProgressDialog pr;

class SignUpInView extends StatefulWidget {
  final AuthFormType authFormType;
  SignUpInView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpInViewState createState() =>
      _SignUpInViewState(authFormType: this.authFormType);
}

class _SignUpInViewState extends State<SignUpInView> {
  double percentage = 0.0;
  AuthFormType authFormType;
  _SignUpInViewState({this.authFormType});

  String _emailadress, _password, _firstname, _lastname;
  final formKey = GlobalKey<FormState>();

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: darkGreyColor,
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.10),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInput() + buildButtons(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create dynamic Header
  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: redBoldText,
    );
  }

// Create dynamic Input
  List<Widget> buildInput() {
    List<Widget> textFields = [];

    if (AuthFormType.signUp == authFormType) {
      //firstname
      textFields.add(
        TextFormField(
          style: redText,
          decoration: buildSignInUpInputDecoration("Firstname"),
          onSaved: (value) => _firstname = value,
        ),
      );
      textFields.add(
        SizedBox(height: 20.0),
      );

      //lastname
      textFields.add(
        TextFormField(
          style: redText,
          decoration: buildSignInUpInputDecoration("Lastname"),
          onSaved: (value) => _lastname = value,
        ),
      );
      textFields.add(
        SizedBox(height: 20.0),
      );
    }
    //Email
    textFields.add(
      TextFormField(
        style: redText,
        decoration: buildSignInUpInputDecoration("Email"),
        onSaved: (value) => _emailadress = value,
      ),
    );
    print(_emailadress);
    textFields.add(
      SizedBox(height: 20.0),
    );

    //Password
    textFields.add(
      TextFormField(
        style: redText,
        decoration: buildSignInUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(
      SizedBox(height: 20.0),
    );
    return textFields;
  }

  InputDecoration buildSignInUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redColor, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _submitButtonText, _switchButtonText, _newFormState;
    if (authFormType == AuthFormType.signIn) {
      _submitButtonText = "Sign In";
      _switchButtonText = "No account! Create new one";
      _newFormState = "signUp";
    } else {
      _submitButtonText = "Sign Up";
      _switchButtonText = " Have an account? Sign In";
      _newFormState = "signIn";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: RaisedButton(
            color: redColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
              child: Text(
                _submitButtonText,
                style: darkTodoTitle,
              ),
            ),
            onPressed: submit,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: FlatButton(
          child: Text(
            _switchButtonText,
            style: bigLightRedNormalTitle,
          ),
          onPressed: () {
            switchFormState(_newFormState);
          },
        ),
      )
    ];
  }

  void loadingDialog() {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );
    pr.style(
//      message: 'Downloading file...',
      message:
          'Lets dump some huge text into the progress dialog and check whether it can handle the huge text. If it works then not you or me, flutter is awesome',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  //Switch beetween SignIn and SignUp
  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  void submit() async {
    ProgressDialog pr;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    final form = formKey.currentState;
    form.save();
    try {
      final auth = Provider.of(context).auth;
      if (authFormType == AuthFormType.signIn) {
        String uid = await auth.signInWithEmailAndPassword(
            _emailadress.trim(), _password);
        if (uid.length > 0) {
          print("Signed In with ID $uid");
          pr.show();
          Future.delayed(Duration(seconds: 2)).then((value) {
            pr.hide().whenComplete(() {
              Navigator.of(context).pushReplacementNamed('/home');
            });
          });
        }
      } else {
        String uid = await auth.createUserWithEmailAndPassword(
            _emailadress.trim(),
            _password,
            _firstname.trim(),
            _lastname.trim());
        if (uid.length > 0) {
          pr.show();
          print("Signed Up with new ID $uid");
          Future.delayed(Duration(seconds: 2)).then((value) {
            pr.hide().whenComplete(() {
              Navigator.of(context).pushReplacementNamed('/signIn');
            });
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

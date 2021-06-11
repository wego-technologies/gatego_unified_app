import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/textInput.dart';
import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userC = TextEditingController();
  final passC = TextEditingController();

  final userFn = FocusNode();
  final passFn = FocusNode();

  String passw = "";
  String user = "";

  bool inP = false;

  @override
  void dispose() {
    super.dispose();

    userFn.dispose();
    userC.dispose();

    passC.dispose();
    passFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor.withBlue(255).withGreen(100)
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(maxWidth: 500, maxHeight: 410),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Material(
                  child: IconButton(
                    onPressed: () {
                      Beamer.of(context).popRoute();
                    },
                    icon: Icon(Icons.close),
                    splashRadius: 20,
                  ),
                ),
                Consumer(
                  builder: (context, watch, widget) {
                    String? jwt = watch(jwtProvider).state;
                    if (jwt.isNotEmpty) {
                      print(jwt);
                      Beamer.of(context).popRoute();
                      return SizedBox();
                    }
                    return Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextInput(
                          setData: (data) => user,
                          icon: Icons.person_outline_rounded,
                          text: "Username",
                          c: userC,
                          fn: userFn,
                          nextFocus: passFn.requestFocus,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextInput(
                          setData: (data) => user,
                          icon: Icons.vpn_key_outlined,
                          text: "Password",
                          c: passC,
                          fn: passFn,
                          nextFocus: passFn.requestFocus,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 50),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).primaryColor,
                            ),
                            shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(55000),
                              ),
                            ),
                          ),
                          onPressed: !inP
                              ? () {
                                  if (userC.text != "" && passC.text != "") {
                                    getJWT(userC.text, passC.text).then((jwt) {
                                      if (jwt != null) {
                                        inP = false;
                                        watch(jwtProvider).state = jwt;
                                      }
                                    });
                                    setState(() {
                                      inP = true;
                                    });
                                  }
                                }
                              : null,
                          icon: !inP
                              ? Icon(Icons.arrow_forward)
                              : SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballRotateChase,
                                    color: Colors.white,
                                  ),
                                ),
                          label: !inP
                              ? Text("Continue")
                              : Text(
                                  "Loading",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

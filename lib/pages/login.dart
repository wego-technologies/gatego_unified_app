import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/textInput.dart';
import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
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

  String passw = '';
  String user = '';

  bool inP = false;
  bool error = false;

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withAlpha(240),
            //borderRadius: BorderRadius.circular (10),
          ),
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxHeight: 700, maxWidth: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Consumer(
                builder: (context, ref, widget) {
                  var acc = ref.watch(accountProvider);

                  if (acc.isLoggedIn()) {
                    Beamer.of(context).popRoute();
                    return const SizedBox();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextInput(
                        setData: (data) => user,
                        icon: Icons.person_outline_rounded,
                        text: 'Username',
                        c: userC,
                        fn: userFn,
                        nextFocus: passFn.requestFocus,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextInput(
                        obscureText: true,
                        setData: (data) => passw,
                        icon: Icons.vpn_key_outlined,
                        text: 'Password',
                        c: passC,
                        fn: passFn,
                        nextFocus: !inP
                            ? () {
                                if (userC.text != '' && passC.text != '') {
                                  acc
                                      .login(userC.text, passC.text)
                                      .then((success) {
                                    if (success) {
                                      inP = false;
                                    } else {
                                      setState(() {
                                        inP = false;
                                        error = true;
                                      });
                                    }
                                  });
                                  setState(() {
                                    inP = true;
                                  });
                                }
                              }
                            : () {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (error)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).errorColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Icon(FluentSystemIcons
                                  .ic_fluent_dismiss_circle_regular),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  'There was an error logging in. Please try again.',
                                  maxLines: 5,
                                ),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.symmetric(
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
                                if (userC.text != '' && passC.text != '') {
                                  acc
                                      .login(userC.text, passC.text)
                                      .then((success) {
                                    print(success);
                                    if (success) {
                                      inP = false;
                                    } else {
                                      setState(() {
                                        inP = false;
                                        error = true;
                                      });
                                    }
                                  });
                                  setState(() {
                                    inP = true;
                                  });
                                }
                              }
                            : null,
                        label: !inP
                            ? const Icon(Icons.arrow_forward)
                            : const SizedBox(
                                height: 25,
                                width: 25,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballRotateChase,
                                  colors: [Colors.white],
                                ),
                              ),
                        icon: !inP
                            ? const Text('Continue')
                            : const Text(
                                'Loading',
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
    );
  }
}

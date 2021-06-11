import 'package:flutter/material.dart';
import 'package:gatego_unified_app/molecules/textInput.dart';
import 'package:gatego_unified_app/providers/userProvider.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCard extends StatelessWidget {
  final bool expanded;

  UserCard({
    required this.expanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Container(
        padding: EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                spreadRadius: 0,
                color: Theme.of(context).shadowColor.withAlpha(50),
                offset: Offset(0, 0),
              )
            ]),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            showModalBottomSheet<dynamic>(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return LoginModal();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: HeroIcon(
                        HeroIcons.user,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: HeroIcon(
                    HeroIcons.arrowRight,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(50000),
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: HeroIcon(
            HeroIcons.user,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

class LoginModal extends StatefulWidget {
  LoginModal({
    Key? key,
  }) : super(key: key);

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final userC = TextEditingController();
  final passC = TextEditingController();

  final userFn = FocusNode();
  final passFn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1.0,
      minChildSize: 1.0,
      initialChildSize: 1.0,
      builder: (context, scrollController) {
        return Consumer(builder: (ctx, watch, widget) {
          return Container(
            constraints: BoxConstraints(maxWidth: 450),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
            ),
            //margin: EdgeInsets.only(bottom: 150, left: 5, right: 20),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextInput(
                  setData: (data) {
                    print(data);
                  },
                  icon: Icons.person_outline_rounded,
                  text: "Username",
                  c: userC,
                  fn: userFn,
                  nextFocus: passFn.requestFocus,
                ),
                SizedBox(
                  height: 15,
                ),
                TextInput(
                  setData: (data) {
                    print(data);
                  },
                  icon: Icons.vpn_key_outlined,
                  text: "Password",
                  c: passC,
                  fn: passFn,
                  nextFocus: passFn.requestFocus,
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) =>
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
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
                  onPressed: () async {
                    String? jwt = await getJWT(userC.text, passC.text);
                    if (jwt != null) {
                      watch(jwtProvider).state = jwt;
                    }
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Continue"),
                )
              ],
            ),
          );
        });
      },
    );
  }
}

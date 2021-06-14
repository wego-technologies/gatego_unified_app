import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final Function(String) setData;
  final TextEditingController c;
  final IconData icon;
  final String text;
  final bool obscureText;
  final FocusNode fn;
  final Function nextFocus;
  const TextInput({
    required this.setData,
    required this.icon,
    required this.text,
    this.obscureText = false,
    Key? key,
    required this.c,
    required this.fn,
    required this.nextFocus,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  var colorIcon = const Color(0xffd8d8d8);
  var colorShadow = const Color(0xffe6e6e6);
  double blurRadius = 5;
  double spreadRadius = 1;

  @override
  void initState() {
    super.initState();
    widget.fn.addListener(() {
      if (widget.fn.hasFocus) {
        setState(() {
          colorIcon = const Color(0xff00a1d3);
          colorShadow = const Color(0xffb2e3f2);
          blurRadius = 2;
          spreadRadius = 5;
        });
      } else {
        setState(() {
          colorIcon = const Color(0xffd8d8d8);
          colorShadow = const Color(0xffe6e6e6);
          blurRadius = 5;
          spreadRadius = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const padding = 8.0;
    var size = MediaQuery.of(context).size.width - padding * 2;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Container(
          //color: Color(0xfff5f5f5),
          width: size,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: blurRadius,
                  spreadRadius: spreadRadius,
                  color: colorShadow)
            ],
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xfff5f5f5),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                widget.icon,
                size: 25,
                color: colorIcon,
              ),
              Expanded(
                //width: size * 0.9,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(15)),
                  child: TextField(
                    controller: widget.c,
                    focusNode: widget.fn,
                    obscureText: widget.obscureText,
                    onSubmitted: (_) {
                      widget.nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onChanged: widget.setData,
                    decoration: InputDecoration(
                      fillColor: const Color(0xfff5f5f5),
                      focusColor: const Color(0xfff5f5f5),
                      hoverColor: const Color(0xfff5f5f5),
                      filled: true,
                      border: InputBorder.none,
                      hintText: widget.text,
                      hintStyle: const TextStyle(
                          color: Color(0xff727272),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

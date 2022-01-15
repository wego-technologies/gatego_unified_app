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

  @override
  void initState() {
    super.initState();
    widget.fn.addListener(() {
      if (widget.fn.hasFocus) {
        setState(() {
          colorIcon = Theme.of(context).primaryColor;
          colorShadow = Theme.of(context).primaryColor;
        });
      } else {
        setState(() {
          colorIcon = Theme.of(context).brightness == Brightness.dark
              ? const Color(0xffd8d8d8)
              : Color.fromARGB(255, 0, 0, 0);
          colorShadow = const Color(0xffe6e6e6);
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
            border: Border.all(color: colorShadow, width: 2),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xfff5f5f5)
                : Color.fromARGB(255, 99, 99, 99),
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
                      fillColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color(0xfff5f5f5)
                              : Color.fromARGB(255, 99, 99, 99),
                      focusColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color(0xfff5f5f5)
                              : Color.fromARGB(255, 99, 99, 99),
                      hoverColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color(0xfff5f5f5)
                              : Color.fromARGB(255, 99, 99, 99),
                      filled: true,
                      border: InputBorder.none,
                      hintText: widget.text,
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color ??
                              Colors.black,
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

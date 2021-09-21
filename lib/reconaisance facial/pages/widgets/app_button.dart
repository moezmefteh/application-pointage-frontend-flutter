import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {this.onPressed,
      this.text,
      this.color = const Color(0xFF0F0BDB),
      this.icon = const Icon(
        Icons.add,
        color: Colors.white,
      )});
  final Function onPressed;
  final String text;
  final Icon icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff7C83FD).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 20, color: Color(0xff0A043C)),
            ),
            SizedBox(
              width: 10,
            ),
            icon
          ],
        ),
      ),
    );
  }
}

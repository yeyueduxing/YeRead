import 'package:flutter/material.dart';

import 'package:tianyue/public.dart';

class NovelFindCell extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconName;
  final String title;

  NovelFindCell({this.title, this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: TYColor.white,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Image.asset(iconName,width: 25,height: 25,),
                  SizedBox(width: 20),
                  Text(title, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset('img/arrow_right.png'),
                ],
              ),
            ),
            Container(
              height: 1,
              color: TYColor.lightGray,
              margin: EdgeInsets.only(left: 60),
            ),
          ],
        ),
      ),
    );
  }
}

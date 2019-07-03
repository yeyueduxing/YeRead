import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

/**
 * 分类顶部视图
 */
class VoideBlockHeaderView extends StatelessWidget {
  final String titleName;

  VoideBlockHeaderView(this.titleName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildHeaderView(),
    );
  }

  Widget buildHeaderView(){
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Image.asset("img/ic_bookstore_title_mark.png"),
          SizedBox(width: 10),
          Text(titleName, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

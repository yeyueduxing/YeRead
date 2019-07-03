import 'package:flutter/material.dart';
import 'package:tianyue/common/style/ye_style.dart';
import 'package:tianyue/public.dart';

/**
 * 分类顶部视图
 */
class ComicBlockHeaderView extends StatelessWidget {
  final String titleName;

  ComicBlockHeaderView(this.titleName);

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
          Image.asset("img/ic_bookstore_title_mark.png",width: 30,height: 30,),
          SizedBox(width: 10),
          Text(titleName, style: YeConstant.normalTextBold),
        ],
      ),
    );
  }
}

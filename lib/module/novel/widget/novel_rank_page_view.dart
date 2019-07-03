import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_block_item_view.dart';
import 'package:tianyue/public.dart';

class NovelPageView extends StatefulWidget {
  final String rankParam;

  NovelPageView(this.rankParam);

  @override
  State<StatefulWidget> createState() {
    return NovelPageViewState();
  }
}

class NovelPageViewState extends State<NovelPageView>
    with AutomaticKeepAliveClientMixin {
  List<NovelBook> bookList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> fetchData() async {
    try {
      bookList = await NovelModel.getRank(widget.rankParam);
      setState(() {});
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  Widget buildModule(BuildContext context, NovelBook module) {
    return NovelBlockItemView(module, Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: fetchData,
        color: TYColor.primary,
        child: ListView.builder(
          itemCount: bookList.length,
          itemBuilder: (BuildContext context, int index) {
            return buildModule(context, bookList[index]);
          },
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/common/db/provide/comic/comic_collect_db_provider.dart';
import 'package:tianyue/common/event/event_dao.dart';
import 'package:tianyue/module/comic/bean/comic_block.dart';

class ComicDao {
  ///获取所有的用户收藏
  static getAllCollect() async {
    ComicCollectDbProvider provider = new ComicCollectDbProvider();
    List<ComicBlock> list = await provider.getAll();
    return list;
  }

  static isCollected(String id) async {
    ComicCollectDbProvider provider = new ComicCollectDbProvider();
    var data = await provider.getData(id);
    if (data == null) {
      return false;
    }
    return true;
  }

  static addCollecte(String title, String sid, String cover) async {
    ComicCollectDbProvider provider = new ComicCollectDbProvider();
    await provider.insert(title, sid, cover).then((result){
      EventDao.sendCollectChange();
    });
  }

  static cancelCollecte(String sid) async {
    ComicCollectDbProvider provider = new ComicCollectDbProvider();
    await provider.delete(sid).then((result){
      EventDao.sendCollectChange();
    });
  }
}

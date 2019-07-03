import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/common/db/provide/comic/comic_collect_db_provider.dart';
import 'package:tianyue/common/db/provide/video/video_collect_db_provider.dart';
import 'package:tianyue/common/event/event_dao.dart';
import 'package:tianyue/module/comic/bean/comic_block.dart';
import 'package:tianyue/module/video/bean/video.dart';

class VideoDao {
  ///获取所有的用户收藏
  static getAllCollect() async {
    VideoCollectDbProvider provider = new VideoCollectDbProvider();
    List<Video> list = await provider.getAll();
    return list;
  }

  static isCollected(String id) async {
    VideoCollectDbProvider provider = new VideoCollectDbProvider();
    var data = await provider.getData(id);
    if (data == null) {
      return false;
    }
    return true;
  }

  static addCollecte(String title, String sid, String cover) async {
    VideoCollectDbProvider provider = new VideoCollectDbProvider();
    await provider.insert(title, sid, cover).then((result){
      EventDao.sendCollectChange();
    });
  }

  static cancelCollecte(String sid) async {
    VideoCollectDbProvider provider = new VideoCollectDbProvider();
    await provider.delete(sid).then((result){
      EventDao.sendCollectChange();
    });
  }
}

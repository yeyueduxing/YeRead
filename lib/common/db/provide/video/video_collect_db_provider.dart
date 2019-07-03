import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tianyue/common/db/sql_provider.dart';
import 'package:tianyue/common/utils/code_utils.dart';
import 'package:tianyue/module/comic/bean/comic_block.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/module/video/bean/video.dart';

/**
 * 动画收藏表
 * Created by guoshuyu
 * Date: 2018-08-07
 */
class VideoCollectDbProvider extends BaseDbProvider {
  final String name = 'VideoCollect';

  final String columnId = "_id";
  final String columnTitle = "title";
  final String columnSid = "sid";
  final String columnCover = "cover";

  int id;
  String title;
  String sid;
  String cover;

  VideoCollectDbProvider();

  Map<String, dynamic> toMap(String title, String sid,String cover) {
    Map<String, dynamic> map = {columnTitle: title, columnSid: sid,columnCover:cover};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  VideoCollectDbProvider.fromMap(Map map) {
    id = map[columnId];
    title = map[columnTitle];
    sid = map[columnSid];
    cover = map[columnCover];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnTitle text not null,
        $columnSid text not null,
        $columnCover text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  Future _getProvider(Database db, String sid) async {
    List<Map<String, dynamic>> maps =
    await db.query(name, columns: [columnId, columnTitle, columnSid,columnCover], where: "$columnSid = ?", whereArgs: [sid]);
    if (maps.length > 0) {
      VideoCollectDbProvider provider = VideoCollectDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入到数据库
  Future insert(String title,String sid,String cover) async {
    Database db = await getDataBase();
    //判断是否重复插入
    var provider = await _getProvider(db, sid);
    if (provider != null) {
      await db.delete(name, where: "$columnSid = ?", whereArgs: [sid]);
    }
    return await db.insert(name, toMap(title, sid,cover));
  }

  ///插入到数据库
  Future delete(String sid) async {
    Database db = await getDataBase();
    return await db.delete(name, where: "$columnSid = ?", whereArgs: [sid]);
  }
  ///插入到数据库
  Future getData(String sid) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps =
    await db.query(name, columns: [columnId, columnTitle, columnSid,columnCover], where: "$columnSid = ?", whereArgs: [sid]);
    ComicBlock comicBlock = new ComicBlock();
    if (maps.length > 0) {
      VideoCollectDbProvider provider = VideoCollectDbProvider.fromMap(maps.first);
      comicBlock.title = provider.title;
      comicBlock.id = provider.sid;
      comicBlock.cover = provider.cover;
      return comicBlock;
    }
    return null;
  }
  ///获取事件数据
  Future<List<Video>> getAll() async {
    Database db = await getDataBase();
    List<Video> list = new List();
    List<Map<String, dynamic>> maps =
    await db.query(name);
    if (maps.length > 0) {
      maps.forEach((map){
        Video comicBlock = new Video();
        VideoCollectDbProvider provider = VideoCollectDbProvider.fromMap(map);
        comicBlock.title = provider.title;
        comicBlock.sId = provider.sid;
        comicBlock.cover = provider.cover;
        list.add(comicBlock);
      });
      return list;
    }
    return list;
  }

}

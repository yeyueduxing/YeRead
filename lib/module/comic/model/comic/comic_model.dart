import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tianyue/app/request.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/comic/bean/comic_rank_entity.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';

/**
 *
 * 漫画数据处理，网络数据处理，缓存数据处理，本地数据处理。将数据处理抽取集中到一个地方
 */
class ComicModel{

  /**
   * 获取漫画首页数据
   */
  static Future<ComicHomeListEntity> getHomeData(BuildContext context) async {
    /**
     * 获取JSON数据
     * booktype 132 男
     *          133 女
     */
    AppState newState = StoreProvider.of<AppState>(context).state;
    int bookType = 133;
    if(newState!=null && newState.role.isBoy){
      bookType = 132;
    }
    var responseJson = await Request.getByHttpClient(
        "http://kanmanapi-main.321mh.com/v1/book/getBookByType?platformname=iphone&booktype="+bookType.toString()+"&productname=aym&pagesize=20");
    ComicHomeListEntity enity = ComicHomeListEntity.fromJson(responseJson);
    return enity;
  }

  static Future<ComicDetailInfoEntity> getDetial(String cId) async {

    //获取漫画详情
    String url = "http://ios-getcomicinfo.321mh.com/app_api/v5/getcomicinfo_body/?platformname=iphone&comic_id="+cId+"&productname=aym";

    var responseJson = await Request.getByHttpClient(url);
    ComicDetailInfoEntity comicDetail = ComicDetailInfoEntity.fromJson(responseJson);
    return comicDetail;
  }

  /**
   * 获取推荐漫画
   */
  static Future<List<ComicRecommendEntity>> getRecommentById(String cId) async {
    //获取推荐漫画
    String recommendUrl = "http://punch-globalapi.321mh.com/app_api/v1/comic/getRecommendComic?platformname=iphone&comic_id="+cId+"&productname=aym";
    var responseJsonRecom = await Request.getByHttpClient(recommendUrl);
    List<ComicRecommendEntity> comicChapter = new List<ComicRecommendEntity>();
    (responseJsonRecom as List).forEach((v) { comicChapter.add(new ComicRecommendEntity.fromJson(v)); });
    return comicChapter;
  }

  /**
   * 获取排行榜
   */
  static Future<ComicRankEntity> getRankList(String rank_type,String stat_type) async {
    String url =  "http://getconfig-globalapi.yyhao.com/app_api/v5/getranklistdetail/?platformname=iphone&productname=aym&rank_type=" +
        rank_type +
        "&stat_type=" +
        stat_type +
        "&limit=100";
    //获取推荐漫画
    var responseJson = await Request.getByHttpClient(url);
    print(url);
    ComicRankEntity comicDetail = ComicRankEntity.fromJson(responseJson);
    return comicDetail;
  }
}
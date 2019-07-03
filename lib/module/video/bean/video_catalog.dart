/**
 * 视频目录
 */
class VideoCatalog {
  String title;
  List<VideoCatalogItem> items;
}

class VideoCatalogItem {
  String title;
  String param;

  VideoCatalogItem(this.title, this.param);
}

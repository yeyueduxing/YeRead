/**
 * 通用的漫画Item界面，图片，标题，描述
 */
class ComicBlock {
  String id;
  String cover;
  String title;
  String description;

  ComicBlock({this.id, this.cover, this.title, this.description});

  ComicBlock.fromJson(Map data) {
    cover = data['cover'];
    title = data['title'];
    description = data['description'];
  }
}

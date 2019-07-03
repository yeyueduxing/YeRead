/**
 * 视频详情
 */
class VideoInfoEntity {
  String sid;
  String time; //播放时间
  String originalTitle; //原版名称
  String title; //名称
  String region; //地区
  String writer; //原作
  String company; //制作公司
  String status; //状态
  String tags; //标签
  String describe; //描述
  String type; //动画种类
  String cover; //图片
  VideoInfoEntity(
      {this.title,
      this.time,
        this.sid,
      this.company,
      this.describe,
      this.originalTitle,
      this.region,
      this.status,
      this.tags,
      this.type,
      this.cover,
      this.writer});

  @override
  String toString() {
    return 'VideoInfoEntity{time: $time, originalTitle: $originalTitle, title: $title, region: $region, writer: $writer, company: $company, status: $status, tags: $tags, describe: $describe, type: $type, cover: $cover}';
  }

}

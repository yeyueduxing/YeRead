import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/bean/video_detail_chapter_entity.dart';
import 'package:tianyue/module/video/bean/video_detail_comment.dart';
import 'package:tianyue/module/video/bean/video_info_entity.dart';

class VideoDetailPage{
  VideoInfoEntity info;
  List<VideoDetailChapterEntity> chapters;
  List<Video> recommends;
  List<VideoDetailComment> comments;
}
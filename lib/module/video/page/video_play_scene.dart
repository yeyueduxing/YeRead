import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';
import 'package:tianyue/module/video/bean/video_home_list.dart';
import 'package:tianyue/module/video/model/video_model.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/module/video/widget/voide_block_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';
import 'package:video_player/video_player.dart';

/**
 * 视频播放
 */

class VideoPlayScene extends StatefulWidget {
  String path;
  VideoPlayScene(this.path);
  @override
  State<StatefulWidget> createState() => VideoPlayState();
}

class VideoPlayState extends State<VideoPlayScene> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        url: widget.path,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
      ),
    );
  }
}

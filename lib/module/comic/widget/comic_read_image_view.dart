import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/ty_color.dart';

class ComicReadImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final BoxFit fit;

  ComicReadImage(this.imgUrl, {this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
          imageUrl: imgUrl,
          fit: fit == null ? BoxFit.cover : fit,
          width: width,
          height: height,
          //添加预加载视图
          placeholder: (context, index) {
            return Container(
              height: 200,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "img/ic_loading_animation.png",
                  height: 50,
                  width: 50,
                ),
              ),
            );
          }),
      decoration: BoxDecoration(border: Border.all(color: TYColor.paper)),
    );
  }
}

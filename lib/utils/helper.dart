import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/scale_ui.dart';

CancelToken cancelToken = CancelToken();

class CustomSpacerHeight extends StatelessWidget {
  final double h;
  const CustomSpacerHeight(this.h, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(h),
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.black,),
    );
  }
}

CachedNetworkImage showImage(url, {double w = 80}) => CachedNetworkImage(
      width: width(w),
      height: double.infinity,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width(w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
          child: Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.grey[100],
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

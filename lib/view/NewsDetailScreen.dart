import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/model/NewsModel.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel newsModel;
  const NewsDetailScreen({super.key, required this.newsModel});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 35,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(widget.newsModel.title.toString(),
                  subject: 'Article');
            },
            child: Image.asset(
              sendIcon,
              height: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customImageForDetail(
                widget.newsModel.imageUrl == null ||
                        widget.newsModel.imageUrl!.trim().isEmpty
                    ? "null"
                    : widget.newsModel.imageUrl.toString(),
                1.sw,
                0.45.sh),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Text(
                      widget.newsModel.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      splitDateForNews(widget.newsModel.scheduled.toString()),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    10.verticalSpace,
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            widget.newsModel.articleText.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  customImageForDetail(String url, double width, double height) {
    return url != "" && url != "null"
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(40),
                  //     bottomRight: Radius.circular(40)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(40),
              //     bottomRight: Radius.circular(40)),
              image: DecorationImage(
                  image: AssetImage(eventPlaceholder), fit: BoxFit.cover),
            ),
          ); //AssetImage(placeholder)
  }
}

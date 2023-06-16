import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/common.dart';
import 'package:tiqarte/helper/images.dart';
import 'package:tiqarte/helper/strings.dart';
import 'package:tiqarte/view/ImagePreviewDialog.dart';

class GalleryScreen extends StatefulWidget {
  final List<String>? previousEventImages;
  const GalleryScreen({super.key, required this.previousEventImages});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List galleryEventImagesList = [
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7,
    galleryEventImage1,
    galleryEventImage2,
    galleryEventImage3,
    galleryEventImage4,
    galleryEventImage5,
    galleryEventImage6,
    galleryEventImage7
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSecondBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        //  backgroundColor: kSecondBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back)),
                      10.horizontalSpace,
                      Text(
                        galleryPreEvent,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.background),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(
                      Icons.more_horiz_sharp,
                      size: 25,
                    ),
                  )
                ],
              ),
              30.verticalSpace,
              Expanded(
                  child: GridView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: widget.previousEventImages?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ImagePreviewDialog(
                            imagePath: widget.previousEventImages![index]),
                      );
                    },
                    child: customCardImage(
                        widget.previousEventImages![index], 110.h, 110.h),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

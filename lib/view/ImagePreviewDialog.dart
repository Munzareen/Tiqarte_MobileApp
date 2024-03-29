import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tiqarte/helper/colors.dart';

class ImagePreviewDialog extends StatefulWidget {
  final String imagePath;
  const ImagePreviewDialog({Key? key, required this.imagePath})
      : super(key: key);
  @override
  _ImagePreviewDialogState createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: InteractiveViewer(
              child: Container(
                height: 0.6.sh,
                width: 0.8.sw,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: kPrimaryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

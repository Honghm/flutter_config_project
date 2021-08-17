import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoViewer extends StatefulWidget {
  PhotoViewer({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    required this.imagePaths,
    required this.images,
    required this.onImageDeleted,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> imagePaths;
  final List<Widget> images;
  final Axis scrollDirection;
  final void Function(List<String> imagePaths, List<Widget> images)
      onImageDeleted;

  @override
  State<StatefulWidget> createState() {
    return _PhotoViewerState();
  }
}

class _PhotoViewerState extends State<PhotoViewer> {
  late int currentIndex = widget.initialIndex;
  late List<String> imagePaths;
  late List<Widget> images;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    images = widget.images;
    imagePaths = widget.imagePaths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: imagePaths.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              child: Material(
                color: Colors.black,
                child: InkWell(
                  onTap: () {
                    removeImage(
                      currentIndex,
                      onImageDeleted: widget.onImageDeleted,
                    );
                    if (imagePaths.isEmpty) Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          '   Xóa',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = imagePaths[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: FileImage(File(item)),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.hashCode),
    );
  }

  void removeImage(
    int index, {
    required Function(List<String> imagePaths, List<Widget> images)
        onImageDeleted,
  }) {
    if (images.isEmpty || imagePaths.isEmpty) return;
    if (index > images.length - 1) {
      setState(() {
        images.removeLast();
        imagePaths.removeLast();
      });
      onImageDeleted(imagePaths, images);

      return;
    }
    setState(() {
      images.removeAt(index);
      imagePaths.removeAt(index);
    });
    onImageDeleted(imagePaths, images);
  }
}

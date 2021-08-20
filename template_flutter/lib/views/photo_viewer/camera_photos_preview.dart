import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraPhotosPreview extends StatefulWidget {
  CameraPhotosPreview({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    required this.onImageDeleted,
    required this.files,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<File> files;
  final Axis scrollDirection;
  final void Function(List<File> files) onImageDeleted;

  @override
  State<StatefulWidget> createState() {
    return _CameraPhotosPreviewState();
  }
}

class _CameraPhotosPreviewState extends State<CameraPhotosPreview> {
  late int currentIndex = widget.initialIndex;
  late List<File> files;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    files = widget.files;
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
              itemCount: files.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Positioned(
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "Chọn tất cả",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(20.w),
              child: Material(
                color: Colors.black,
                child: InkWell(
                  onTap: () async {
                    await removeImage(
                      currentIndex,
                      onImageDeleted: widget.onImageDeleted,
                    );
                    if (files.isEmpty) Navigator.pop(context);
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
                              fontSize: 16,
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
    final File item = files[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: FileImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.hashCode),
    );
  }

  Future removeImage(
    int index, {
    required Function(List<File> files) onImageDeleted,
  }) async {
    if (files.isEmpty) return;
    if (index > files.length - 1) {
      await files.last.delete();
      setState(() {
        files.removeLast();
      });
      onImageDeleted(files);
      return;
    }
    await files[index].delete();
    setState(() {
      files.removeAt(index);
    });
    onImageDeleted(files);
  }
}

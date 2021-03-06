import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/common/utils/tools.dart';
import 'package:template_flutter/views/photo_viewer/camera_view.dart';

class ImageModel {
  String path;
  Widget image;
  ImageModel(this.path, this.image);
}

class GalleryViewScreen extends StatefulWidget {
  static final id = 'GalleryViewScreen';
  const GalleryViewScreen({Key? key}) : super(key: key);

  @override
  _GalleryViewScreenState createState() => _GalleryViewScreenState();
}

class _GalleryViewScreenState extends State<GalleryViewScreen> {
  List<String> imagePaths = [];
  List<Widget> images = [];
  Widget _buildImage(String path) {
    return GestureDetector(
      onTap: () {
        Utils.openPhotoViewer(context,
            index: imagePaths.indexOf(path),
            imagePaths: imagePaths,
            images: images, onImageDeleted: (paths, imgs) {
          setState(() {
            imagePaths = paths;
            images = imgs;
          });
        });
      },
      child: Image.file(
        File(path),
        height: 100,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Gallery Demo"),
      ),
      body: Column(
        children: [
          Spacer(),
          ElevatedButton(
              onPressed: () async {
                await Utils.pickImageFromGallery(context, maxAssets: 1,
                    success: (paths) {
                  setState(() {
                    imagePaths.addAll(paths);
                    paths.forEach((element) {
                      images.add(_buildImage(element));
                    });
                  });
                });
              },
              child: Text("Pick single image from gallery")),
          ElevatedButton(
              onPressed: () async {
                await Utils.pickImageFromGallery(context, success: (paths) {
                  setState(() {
                    imagePaths.addAll(paths);
                    paths.forEach((element) {
                      images.add(_buildImage(element));
                    });
                  });
                });
              },
              child: Text("Pick multiple images from gallery")),
          ElevatedButton(
              onPressed: () => Utils.pickMultipleImagesFromCamera(
                    context,
                    onPicked: (paths) {
                      setState(() {
                        imagePaths.addAll(paths);
                        images.addAll(paths.map(_buildImage));
                      });
                    },
                  ),
              child: Text("Pick multiple images from camera")),
          ElevatedButton(
              onPressed: () => Utils.pickSingleImageFromCamera(
                    context,
                    onPicked: (path) {
                      setState(() {
                        imagePaths.add(path);
                        images.add(_buildImage(path));
                      });
                    },
                  ),
              child: Text("Pick single image from camera")),
          Spacer(),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(
                width: 20,
              ),
              itemBuilder: (context, index) => images[index],
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}

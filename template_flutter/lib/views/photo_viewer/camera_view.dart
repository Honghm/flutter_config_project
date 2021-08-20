import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/common/utils/tools.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key,
      this.isSinglePhoto = false,
      this.resolutionPreset = ResolutionPreset.medium,
      required this.onResult})
      : super(key: key);
  final bool isSinglePhoto;
  final ResolutionPreset resolutionPreset;
  final void Function(dynamic) onResult;
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late Future initWidget;
  late final List<CameraDescription> cameras;
  late CameraController _controller;
  List<File> images = [];
  @override
  void initState() {
    super.initState();
    initWidget = initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      widget.resolutionPreset,
    );

    await _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initWidget,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                Positioned.fill(child: CameraPreview(_controller)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: FloatingActionButton(
                      onPressed: () async {
                        try {
                          await initWidget;

                          final image = await _controller.takePicture();
                          if (widget.isSinglePhoto) {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SinglePhotoPreview(
                                        image: File(image.path))));
                            if (result) {
                              widget.onResult(image.path);
                              Navigator.pop(context);
                            }
                          } else {
                            setState(() {
                              images.add(File(image.path));
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.isSinglePhoto,
                  child: Positioned(
                    bottom: 10,
                    right: 10,
                    child: images.isNotEmpty
                        ? _buildPreviewImage(images.last)
                        : SizedBox(),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPreviewImage(file) => GestureDetector(
        onTap: () async {
          if (images.isNotEmpty) {
            final result = await Utils.openCameraPhotoPreview(
              context,
              index: images.length - 1,
              files: images,
              onImageDeleted: (newFiles) {
                setState(() {
                  images = newFiles;
                });
              },
            );
            if (result != null && result == true) {
              widget.onResult(images.map((e) => e.path).toList());
              Navigator.pop(context);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.lightBlueAccent,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              file,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      );
}

class SinglePhotoPreview extends StatelessWidget {
  const SinglePhotoPreview({Key? key, required this.image}) : super(key: key);
  final File image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Image.file(
              image,
              fit: BoxFit.cover,
            )),
            Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                child: Text("Chọn"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () => Navigator.pop(context, false),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                ))
          ],
        ),
      ),
    );
  }
}

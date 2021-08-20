import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:template_flutter/generated/i10n.dart';
import 'package:template_flutter/views/photo_viewer/camera_photos_preview.dart';
import 'package:template_flutter/views/photo_viewer/camera_view.dart';
import 'package:template_flutter/views/photo_viewer/photo_viewer.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Utils {
  static Function getLanguagesList = ([context]) {
    return [
      {
        "name": context != null ? S.of(context)!.english : "English",
        "icon": "",
        "code": "en",
        "text": "English",
        "storeViewCode": ""
      },
      {
        "name": context != null ? S.of(context)!.vietnamese : "Vietnam",
        "icon": "",
        "code": "vi",
        "text": "Vietnam",
        "storeViewCode": ""
      },
    ];
  };

  ///Chọn 1 hoặc nhiều ảnh từ Gallery
  ///
  ///* [themeColor] : primaryColor trong theme của [AssetPicker].
  ///* [success] : callback được gọi khi người dùng chọn xong hình với tham số
  ///là List<String> - đường dẫn tuyệt đối của các hình.
  static Future pickImageFromGallery(
    BuildContext context, {
    Color themeColor = Colors.blue,
    required Function(List<String>) success,
    int maxAssets = 9,
  }) async {
    List<String> listImagePath = [];
    final images = await AssetPicker.pickAssets(
      context,
      textDelegate: VietnameseTextDelegate(),
      maxAssets: maxAssets,
      specialPickerType: maxAssets == 1 ? SpecialPickerType.noPreview : null,
      themeColor: themeColor,
    );
    if (images != null) {
      for (AssetEntity element in images) {
        final file = await element.file;
        listImagePath.add(file!.path);
      }
    }
    success(listImagePath);
  }

  ///Mở gallery view
  ///
  ///* [index], index của ảnh được hiển thị lên đầu tiên khi mở gallery view.
  ///* [images], list ảnh muốn hiển thị.
  ///* [imagePaths], list đường dẫn tuyệt đối của ảnh trong [images].
  ///* [onImageDeleted], hàm callback được gọi khi có ảnh bị xóa.
  ///* [newImagePaths], list đường dẫn tuyệt đối của ảnh trong [newImages]
  ///sau khi đã xóa ảnh.
  static void openPhotoViewer(
    BuildContext context, {
    required int index,
    required List<String> imagePaths,
    required List<Widget> images,
    required void Function(List<String> newImagePaths, List<Widget> newImages)
        onImageDeleted,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewer(
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
          imagePaths: imagePaths,
          images: images,
          onImageDeleted: onImageDeleted,
        ),
      ),
    );
  }

  ///Mở preview của các hình đã chụp khi chụp nhiều hình
  ///qua hàm [pickMultipleImagesFromCamera]
  static Future openCameraPhotoPreview(
    BuildContext context, {
    required int index,
    required List<File> files,
    required void Function(List<File> files) onImageDeleted,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPhotosPreview(
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
          files: files,
          onImageDeleted: onImageDeleted,
        ),
      ),
    );
  }

  ///Chụp 1 hình từ camera
  static void pickSingleImageFromCamera(BuildContext context,
      {required void Function(String path) onPicked}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraView(
          isSinglePhoto: true,
          onResult: (res) {
            final String result = res;
            onPicked(result);
          },
        ),
      ),
    );
  }

  ///Chụp nhiều hình từ camera
  static void pickMultipleImagesFromCamera(BuildContext context,
      {required void Function(List<String> paths) onPicked}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraView(
          isSinglePhoto: false,
          onResult: (res) {
            final List<String> result = res;
            onPicked(result);
          },
        ),
      ),
    );
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

/// [AssetsPickerTextDelegate] implements with Vietnamese.
/// Vietnam Localization
class VietnameseTextDelegate extends AssetsPickerTextDelegate {
  @override
  String get confirm => 'Đồng ý';

  @override
  String get cancel => 'Hủy';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get heicNotSupported => 'Không hỗ trợ tệp định dạng HEIC.';

  @override
  String get loadFailed => 'Load thất bại';

  @override
  String get original => 'Gốc';

  @override
  String get preview => 'Xem trước';

  @override
  String get select => 'Chọn';

  @override
  String get unSupportedAssetType => 'Định dạng HEIC không được hỗ trợ.';

  @override
  String get unableToAccessAll =>
      'Không thể truy cập tất cả các tệp trong thiết bị này.';

  @override
  String get viewingLimitedAssetsTip =>
      'Chỉ xem được tệp và album được cấp quyền truy cập.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Cập nhật danh sách tệp được phép truy cập.';

  @override
  String get accessAllTip =>
      'Ứng dụng chỉ có thể truy cập một số tệp trong thiết bị này. '
      'Đi đến cài đặt và cấp quyền cho ứng dụng để có thể truy cập tất cả tệp trong thiết bị.';

  @override
  String get goToSystemSettings => 'Đi đến cài đặt.';

  @override
  String get accessLimitedAssets => 'Tiếp tục với quyền truy cập bị giới hạn.';

  @override
  String get accessiblePathName => 'Các tệp có thể truy cập.';
}

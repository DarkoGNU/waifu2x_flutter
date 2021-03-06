import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;

class GalleryPicker extends StatefulWidget {
  const GalleryPicker({Key? key}) : super(key: key);

  @override
  _GalleryPickerState createState() => _GalleryPickerState();
}

class _GalleryPickerState extends State<GalleryPicker>
    with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();

  @override
  bool get wantKeepAlive => _images?.isNotEmpty ?? false;

  List<XFile>? _images;
  int get _imageCount => _images?.length ?? 0;

  String get _countString {
    switch (_imageCount) {
      case 0:
        return "No images selected";
      case 1:
        return "1 image selected";
      default:
        return "$_imageCount images selected";
    }
  }

  Future<void> _handleButtonPress() async {
    List<XFile>? newImages = await _picker.pickMultiImage();

    setState(() {
      _images = newImages;
    });
  }

  // Only for Android
  // ImagePicker needs to retrieve lost images after the app is killed
  Future<void> _retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty || response.files == null) {
      return;
    }

    setState(() {
      _images = response.files;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: Platform.isAndroid ? _retrieveLostData() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Retrieving selected images...",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: const Text(
                  "Pick images from gallery",
                ),
                onPressed: _handleButtonPress,
              ),
              Text(
                _countString,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

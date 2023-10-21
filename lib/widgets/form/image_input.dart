import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final bool showPreview;
  final Function onSelectImage;

  ImageInput(
    this.showPreview,
    this.onSelectImage,
  );

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  PickedFile _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    List<int> imageBytes = await imageFile.readAsBytes();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage =
    //     await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showPreview && _storedImage != null) ...[
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
              child: Image.file(
                File(_storedImage.path),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 10,
            ),
          ],
          TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            onPressed: _takePicture,
          ),
        ],
      ),
    );
  }
}

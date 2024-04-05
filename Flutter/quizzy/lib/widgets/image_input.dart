import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = TextButton.icon(
    //   icon: const Icon(Icons.image),
    //   label:  Text('Add Image', style: TextStyle(
    //     color: Theme.of(context).primaryColor,
    //   ),),
    //   onPressed: _takePicture,
    // );

    // if (_selectedImage != null) {
    //   content = GestureDetector(
    //     onTap: _takePicture,
    //     child: Image.file(
    //       _selectedImage!,
    //       fit: BoxFit.cover,
    //       width: double.infinity,
    //       height: double.infinity,
    //     ),
    //   );
    // }

    return Column(children: [
      CircleAvatar(
        radius: 60,
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey,
          foregroundImage:
              _selectedImage != null ? FileImage(_selectedImage!) : null,
        ),
      ),
      TextButton.icon(
        icon: const Icon(Icons.image),
        label: Text(
          'Add Image',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: _takePicture,
      )
    ]);
  }
}
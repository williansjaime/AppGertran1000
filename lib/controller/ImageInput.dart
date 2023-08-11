import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
  });

  @override
  ImageInputState createState() => ImageInputState();
}

class ImageInputState extends State<ImageInput> 
{
  File? _storedImage;
  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;
 
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }
 
  @override
  void initState() {
    super.initState();
    _takePicture();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
      Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey )
        ),
        alignment: Alignment.center,
        child: _storedImage != null ? 
        Image.file(
          _storedImage!,
          width: double.infinity,
          fit: BoxFit.cover,
          )
        : Text("Nenhuma imagem!!"),
      ),
      SizedBox(width: 10,),
      Expanded(child: TextButton.icon(
        onPressed: ()=> _takePicture()
      , icon: Icon(Icons.camera)
      , label: Text("Tirar Uma Foto")))
    ],);
  }
}

/*
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}*/
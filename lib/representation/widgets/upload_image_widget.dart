import 'package:flutter/material.dart';

class ImageUploaderWidget extends StatefulWidget {
  const ImageUploaderWidget({super.key});

  @override
  State<ImageUploaderWidget> createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: const Center(
          child: /*_image == null*/
              Text('No image selected.')
          // : Image.file(_image!),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Upload Image'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

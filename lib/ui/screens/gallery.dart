import 'dart:io';

import 'package:chatbot/ui/screens/image_creater.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/text_widget.dart';

class Gallery extends StatefulWidget {
  static const String routeName = '/gallery';
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List imgList = [];

  getImages() async {
    final directory = Directory("storage/emulated/0/AI Image Gallery");
    imgList = directory.listSync();
  }

  popImage(filePath) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFCCCCFF),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1),
                    const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1),
                  ],
                ),
                child: Image.file(
                  filePath,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        setState(() {
          getImages();
          Navigator.pop(context);
        });

        //ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Deleted successfully!",
          ),
          backgroundColor: Colors.deepOrangeAccent,
          // ),
        );
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text("Art Gallery"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageGenerator())),
              icon: const Icon(
                Icons.add_a_photo,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        child: imgList.isEmpty
            ? const Center(
                child: Text(
                'No item found!',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Confirmation'),
                          content: const Text(
                              'Are you sure you want to delete this image?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final fileLocation = "${imgList[index]}";
                                final filePath = fileLocation
                                    .replaceAll(RegExp('File: '), '')
                                    .replaceAll("'", "");

                                deleteFile(File(filePath));
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    onTap: () {
                      popImage(imgList[index]);
                    },
                    child: Image.file(
                      imgList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

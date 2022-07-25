import 'dart:developer' as devtools;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ImageToPdf extends StatefulWidget {
  const ImageToPdf({Key? key}) : super(key: key);

  @override
  State<ImageToPdf> createState() => _ImageToPdfState();
}

class _ImageToPdfState extends State<ImageToPdf> {
  final TextEditingController _fileName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _imageFileList = [];
  final pdf = pw.Document();

  void selectImage() async {
    try {
      final selectImage = await _picker.pickMultiImage();
      if (selectImage != null) {
        for (var x in selectImage) {
          _imageFileList.add(File(x.path));
        }
      }
      setState(() {});
    } catch (e) {
      devtools.log('No image selected');
    }
  }

  void createPdf() async {
    for (var img in _imageFileList) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      try {
        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.letter,
            build: (pw.Context contex) {
              return pw.Center(child: pw.Image(image));
            }));
      } catch (e) {
        continue;
      }
    }
  }

  void savePdf(String filename) async {
    try {
      final file = File('/storage/emulated/0/Documents/$filename.pdf');
      await file.writeAsBytes(await pdf.save());
      showSnackBar('saved to documents');
      setState(() {
        _imageFileList.clear();
      });
    } catch (e) {
      devtools.log(e.toString());
      showSnackBar('some error occured');
    }
  }

  showSnackBar(content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.02,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          content,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    ));
  }

  showAlertDialog() {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Save file as"),
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _fileName,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  createPdf();
                  savePdf(_fileName.text);
                  _fileName.text = '';
                },
                child: const Text('Save'))
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text('Image to pdf converter'),
        centerTitle: true,
        actions: [
          _imageFileList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    showAlertDialog();
                  },
                  icon: const Icon(
                    Icons.save_outlined,
                  ))
              : Container()
        ],
      ),
      floatingActionButton: _imageFileList.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  onPressed: selectImage,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _imageFileList.clear();
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            )
          : Container(),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageFileList.isEmpty
                  ? TextButton(
                      onPressed: selectImage,
                      child: const Text('select image'),
                    )
                  : Container(),
              _imageFileList.isNotEmpty
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 12, left: 12),
                        child: ListView.builder(
                            itemCount: _imageFileList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: Image.file(
                                  File(_imageFileList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

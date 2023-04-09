import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'provider_class.dart';
import 'package:provider/provider.dart';

class filefield extends StatefulWidget {

  filefield(this.title, this.selection, this.model);

  final bool selection;
  final String title;
  final Model model;

  @override
  State<filefield> createState() => _filefieldState();
}

class _filefieldState extends State<filefield> {

  final ImagePicker _picker = ImagePicker();
  dynamic pageImage;

  _pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.files.single.path.toString());
      });
      await _renderImage();
    }
  }

  _renderImage() async {
    final document = await PdfDocument.openFile(image!.path);
    final page = await document.getPage(1);
    final pageRender = await page.render(width: page.width, height: page.height);

    setState(() {
      pageImage = pageRender!.bytes;
    });
    await page.close();
  }

  _pickImage(ImageSource src) async {

    final XFile? result = await _picker.pickImage(source: src);
    setState(() {
      image = File(result!.path);
    });
  }
  File? image;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>.value(
      value: widget.model,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: Consumer<Model>(
              builder: (context, Model, child) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.31,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: widget.selection == false ? () {
                                  showModalBottomSheet(context: context, builder: (context) {
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                                            child: IconButton(
                                                onPressed: ()async {
                                                  await _pickImage(ImageSource.camera);
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    Model.increment_i();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40.0, color: Colors.blue,)),
                                          ),
                                          Text(
                                            'Or',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17.0,
                                                fontFamily: 'Alexandria'),
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                                            child: IconButton(
                                                onPressed: () async{
                                                  await _pickImage(ImageSource.gallery);
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    Model.increment_i();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.folder_copy_outlined,
                                                  size: 40.0, color: Colors.blue,)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                } : () {
                                  showModalBottomSheet(context: context, builder: (context) {
                                    return Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                                            child: IconButton(
                                                onPressed: () async{
                                                  await _pickImage(ImageSource.camera);
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    Model.increment_i();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40.0, color: Colors.blue,)),
                                          ),
                                          Text(
                                            'Or',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17.0,
                                                fontFamily: 'Alexandria'),
                                          ),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                                            child: IconButton(
                                                onPressed: () async{
                                                  await _pickFile();
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    Model.increment_i();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.folder_copy_outlined,
                                                  size: 40.0, color: Colors.blue,)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                                child: widget.selection ? Container(
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  height: 65.0,
                                  color: Colors.white,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${widget.title}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          image != null && pageImage != null ? Container(
                                            child: Image(image: MemoryImage(pageImage), fit: BoxFit.fill,),
                                            height: 55,
                                            width: 48,
                                          ) : Container()
                                        ],
                                      )
                                  ),
                                ) : Container(
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  height: 65.0,
                                  color: Colors.white,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${widget.title}',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          image != null ? Container(
                                            child: Image.file(image!, fit: BoxFit.cover,),
                                            height: 55,
                                            width: 48,
                                          ) : Container()
                                        ],
                                      )
                                  ),
                                )
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: IconButton(
                          onPressed: () {
                            if(image!=null){
                              setState(() {
                                image = null;
                              });
                              Model.decrement_i();
                              }
                            },
                          icon: Icon(Icons.delete, color: Colors.white,size: 30,)),
                    )
                  ],
                );
              }
          ),
        )
    );
  }
}
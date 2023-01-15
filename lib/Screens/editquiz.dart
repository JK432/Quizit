import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizit/Functions/database.dart';

import '../Functions/colorfunction.dart';

class Editquiz extends StatefulWidget {
  final quiz;
  final title;
  final id;
  final desc;
  const Editquiz({this.title, this.desc, this.id, this.quiz});

  @override
  _EditquizState createState() => _EditquizState(quiz);
}

class _EditquizState extends State<Editquiz> {
  final _formKey = GlobalKey<FormState>();
  final quiz;
  _EditquizState(this.quiz);
  String image2url = "";
  String qest = "";
  String op1 = "";
  String op2 = "";
  String op3 = "";
  String op4 = "";
  String desc = "";
  int ans = 0;
  File? file1;
  UploadTask? task2;
  int selectedAns = 0;

  @override
  bool? c1value = false;
  bool? c2value = false;
  bool? c3value = false;
  bool? c4value = false;

  Widget build(BuildContext context) {
    final fileName1 = file1 != null
        ? basename(file1!.path)
        : "12345678901234Select front page";

    return Scaffold(
      backgroundColor: Palette.darkbasic,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: (){

                    Navigator.of(context).pop();
                    DB().Deletequestion(docid: widget.id, id:  widget.quiz.id, url:  widget.quiz.imurl);
                  }, icon: Icon(Icons.delete_outline,color: Palette.basic,), label: Text("Delete", style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Palette.basic))),
            )
          ],
          iconTheme: const IconThemeData(color: Palette.container),
          backgroundColor: Palette.basic,
          title: const Text(
            "Add Question",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Palette.container),
          )),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextFormField(
                      initialValue: widget.quiz.question,
                      style: const TextStyle(color: Palette.container),

                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Palette.lightbasic),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.lightbasic, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Palette.container, width: 2.0),
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      ),
                      maxLines: 8,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Question';
                        } else {
                          qest = value;
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                        activeColor: Palette.container,
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Palette.container, fontSize: 17.0),
                            initialValue: widget.quiz.op1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 1",
                              hintStyle: TextStyle(color: Palette.lightbasic),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.lightbasic, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.container, width: 2.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            ),
                            validator: (option) {
                              if (option == null || option.isEmpty) {
                                return 'Please enter option 1';
                              } else {
                                op1 = option;
                                return null;
                              }
                            },
                          ),
                        ),
                        value: 1,
                        groupValue: quiz.ans,
                        onChanged: (value) {
                          setState(() {
                            quiz.ans = 1;
                            selectedAns = 1;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Palette.container, fontSize: 17.0),
                            initialValue: widget.quiz.op2,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 2",
                              hintStyle: TextStyle(color: Palette.lightbasic),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.lightbasic, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            ),
                            validator: (option) {
                              if (option == null || option.isEmpty) {
                                return 'Please enter option 2';
                              } else {
                                op2 = option;
                                return null;
                              }
                            },
                          ),
                        ),
                        value: 2,
                        groupValue: quiz.ans,
                        onChanged: (value) {
                          setState(() {
                            quiz.ans = 2;
                            selectedAns = 2;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Palette.container, fontSize: 17.0),
                            initialValue: widget.quiz.op3,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 3",
                              hintStyle: TextStyle(color: Palette.lightbasic),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.lightbasic, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            ),
                            validator: (option) {
                              if (option == null || option.isEmpty) {
                                return 'Please enter option 3';
                              } else {
                                op3 = option;
                                return null;
                              }
                            },
                          ),
                        ),
                        value: 3,
                        groupValue: quiz.ans,
                        onChanged: (value) {
                          setState(() {
                            quiz.ans = 3;
                            selectedAns = 3;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Palette.container, fontSize: 17.0),
                            initialValue: widget.quiz.op4,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 4",
                              hintStyle: TextStyle(color: Palette.lightbasic),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Palette.lightbasic, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                            ),
                            validator: (option) {
                              if (option == null || option.isEmpty) {
                                return 'Please enter option 4';
                              } else {
                                op4 = option;
                                return null;
                              }
                            },
                          ),
                        ),
                        value: 4,
                        groupValue: quiz.ans,
                        onChanged: (value) {
                          setState(() {
                            quiz.ans = 4;
                            selectedAns = 4;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style:
                            const TextStyle(color: Palette.container, fontSize: 17.0),
                        initialValue: widget.quiz.desc,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Enter answer Description",
                          hintStyle: TextStyle(color: Palette.lightbasic),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Palette.lightbasic, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        ),
                        validator: (option) {
                          if (option == null || option.isEmpty) {
                            return 'Please Enter Description';
                          } else {
                            desc = option;
                            return null;
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Upload Image for discription",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.lightbasic)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                height: 150,
                                child: widget.quiz.imurl == "No images" ||
                                        image2url == "No images"
                                    ? file1 == null
                                        ? const Text("No image uploaded",    style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.lightbasic))
                                        : Image(image: FileImage(file1!))
                                    : Image.network(
                                        widget.quiz.imurl,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const Text('Error loading image...',    style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.lightbasic));
                                        },
                                      ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        if (image2url != "No images") {
                                          try {
                                            DB().Deletefile(image2url,
                                                widget.id, widget.quiz.id);
                                          } catch (e) {}
                                        } else {
                                          if (widget.quiz.imurl != "No images") {

                                            try {
                                              DB().Deletefile(widget.quiz.imurl,
                                                  widget.id, widget.quiz.id);
                                            } catch (e) {}
                                          }
                                        }
                                        setState(() {
                                          image2url = "No images";
                                          widget.quiz.imurl = "No images";
                                          file1 = null;
                                        });
                                        selectFile2();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Palette.container,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Palette.basic, // Background color
                                      ),
                                      label: const Text("Camera",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.container))),
                                  const Text("Or",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.lightbasic)),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        if (image2url != "No images" && image2url!="") {
                                          try {
                                            DB().Deletefile(image2url,
                                                widget.id, widget.quiz.id);
                                          } catch (e) {}
                                        } else {
                                          if (widget.quiz.imurl != "No images") {
                                            try {
                                              DB().Deletefile(widget.quiz.imurl,
                                                  widget.id, widget.quiz.id);
                                            } catch (e) {}
                                          }
                                        }
                                        setState(() {
                                          image2url = "No images";
                                          widget.quiz.imurl = "No images";
                                          file1 = null;
                                        });
                                        selectFile1();
                                      },
                                      icon: const Icon(
                                        Icons.folder_open,
                                        color: Palette.container,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Palette.basic, // Background color
                                      ),
                                      label: const Text(" Gallery ",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.container))),
                                  ElevatedButton.icon(
                                      onPressed: () async {
                                        if (image2url != "No images" && image2url!="") {
                                          try {
                                            DB().Deletefile(image2url,
                                                widget.id, widget.quiz.id);
                                          } catch (e) {}
                                        } else {
                                          if (widget.quiz.imurl != "No images") {
                                            try {
                                              DB().Deletefile(widget.quiz.imurl,
                                                  widget.id, widget.quiz.id);
                                            } catch (e) {}
                                          }
                                        }
                                        setState(() {
                                          image2url = "No images";
                                          widget.quiz.imurl = "No images";
                                          file1 = null;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Palette.failure,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Palette.basic, // Background color
                                      ),
                                      label: const Text(" Delete ",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Palette.failure))),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    task2 != null ? buildUploadStatus(task2!) : Container(),
                    const Divider(),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Palette.container, // Background color
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      uploadFile(file1);
                    } else {
                      const message = 'Enter the every data';
                      const snackbar = SnackBar(content: Text(message));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  icon: const Icon(
                    Icons.update,
                    color: Palette.basic,
                  ),
                  label: const Text('Update question',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Palette.basic)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile1() async {

    ImageSource source = ImageSource.gallery;
    final ImagePicker _picker = ImagePicker();
    final pickedimage = await _picker.pickImage(source: source);
    if (pickedimage == null) return;
    var result = await ImageCropper().cropImage(
        sourcePath: pickedimage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

    if (result == null) return;
    final path = result.path;
    setState(() {
      file1 = File(path);
      widget.quiz.imurl = "No images";
      image2url = "No images";
    });
  }

  Future selectFile2() async {

    ImageSource source = ImageSource.camera;
    final ImagePicker _picker = ImagePicker();
    final pickedimage = await _picker.pickImage(source: source);
    if (pickedimage == null) return;
    var result = await ImageCropper().cropImage(
        sourcePath: pickedimage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.2));

    if (result == null) return;
    final path = result.path;

    setState(() {
      file1 = File(path);
      widget.quiz.imurl = "No images";
      image2url = "No images";
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            if (percentage == "100.00") {
              return const Text(
                'Uploaded',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Palette.lightbasic),
              );
            } else {
              return Text(
                '$percentage %',
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Palette.lightbasic),
              );
            }
          } else {
            return Container();
          }
        },
      );

  Future uploadFile(image1) async {
    if (file1 == null) {
      if (widget.quiz.imurl == "No images") {
        DB().updatequest(
            id: widget.quiz.id,
            question: qest,
            op1: op1,
            op2: op2,
            op3: op3,
            op4: op4,
            ans: quiz.ans,
            docid: widget.id,
            url: "No images",
            desc: desc);
      } else {
        DB().updatequest(
            id: widget.quiz.id,
            question: qest,
            op1: op1,
            op2: op2,
            op3: op3,
            op4: op4,
            ans: quiz.ans,
            docid: widget.id,
            url: widget.quiz.imurl,
            desc: desc);
      }
    } else {
      final fileName1 = basename(image1!.path);
      final destination1 = 'Images/$fileName1';
      task2 = DB.uploadFile(destination1, image1!);
      setState(() {});
      if (task2 == null) return;
      final snapshot2 = await task2!.whenComplete(() {});
      final urlDownload2 = await snapshot2.ref.getDownloadURL();
      setState(() {
        image2url = urlDownload2;
        widget.quiz.imurl = urlDownload2;
      });
      DB().updatequest(
          id: widget.quiz.id,
          question: qest,
          op1: op1,
          op2: op2,
          op3: op3,
          op4: op4,
          ans: quiz.ans,
          docid: widget.id,
          url: image2url,
          desc: desc);
    }
  }
}

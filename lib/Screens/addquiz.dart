import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizit/Functions/database.dart';

import '../Functions/colorfunction.dart';

class Addquiz extends StatefulWidget {
  final title;
  final id;
  final desc;
  const Addquiz({this.title, this.desc, this.id});

  @override
  _AddquizState createState() => _AddquizState();
}

class _AddquizState extends State<Addquiz> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  bool? c1value = false;
  bool? c2value = false;
  bool? c3value = false;
  bool? c4value = false;
  int selectedAns = 0;
  Widget build(BuildContext context) {
    final fileName1 = file1 != null
        ? basename(file1!.path)
        : "12345678901234Select front page";
    // bool value=false;

    return Scaffold(
      backgroundColor: Palette.darkbasic,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Palette.container ),
          backgroundColor:Palette.basic,
          title: const Text("Add Question",
            style: TextStyle(fontStyle: FontStyle.italic,
                fontWeight:FontWeight.bold,
                color: Palette.container),)),
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
                      style: TextStyle(color: Palette.container),

                      decoration: const InputDecoration(

                        hintText: "Enter the Question",

                        hintStyle: TextStyle(
                            color: Palette.lightbasic),
                        enabledBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Palette.lightbasic, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:BorderSide(color: Palette.container, width: 2.0),
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
                            style: TextStyle(color: Palette.container,fontSize: 17.0),
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 1",
                              hintStyle: TextStyle(
                                  color: Palette.lightbasic),
                              enabledBorder:  OutlineInputBorder(
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
                        groupValue: selectedAns,
                        onChanged: (value) {
                          setState(() {
                            selectedAns = 1;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: TextStyle(color: Palette.container,fontSize: 17.0),
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 2",
                              hintStyle: TextStyle(
                                  color: Palette.lightbasic),
                              enabledBorder:  OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Palette.lightbasic, width: 2.0),
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
                        groupValue: selectedAns,
                        onChanged: (value) {
                          setState(() {
                            selectedAns = 2;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: TextStyle(color: Palette.container,fontSize: 17.0),
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 3",
                              hintStyle: TextStyle(
                                  color: Palette.lightbasic),
                              enabledBorder:  OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Palette.lightbasic, width: 2.0),
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
                        groupValue: selectedAns,
                        onChanged: (value) {
                          setState(() {
                            selectedAns = 3;
                          });
                        }),
                    RadioListTile(
                        title: Container(
                          width: MediaQuery.of(context).size.width - 68,
                          child: TextFormField(
                            style: TextStyle(color: Palette.container,fontSize: 17.0),
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: "Enter Option 4",
                              hintStyle: TextStyle(
                                  color: Palette.lightbasic),
                              enabledBorder:  OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Palette.lightbasic, width: 2.0),
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
                        groupValue: selectedAns,
                        onChanged: (value) {
                          setState(() {
                            selectedAns = 4;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Palette.container,fontSize: 17.0),
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Enter answer Description",
                          hintStyle: TextStyle(
                              color: Palette.lightbasic),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Palette.lightbasic, width: 2.0),
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
                          Text("Upload Image for discription",style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.lightbasic)),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      selectFile2();
                                    },

                                    icon: const Icon(FontAwesomeIcons.camera,color: Palette.container,),
                                    style: ElevatedButton.styleFrom(
                                      primary: Palette.basic, // Background color
                                    ),
                                    label: const Text("Camera",style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container))),
                                Text("Or",style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.lightbasic)),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      selectFile1();
                                    },
                                    icon: const Icon(FontAwesomeIcons.folder,color: Palette.container,),
                                    style: ElevatedButton.styleFrom(
                                      primary: Palette.basic, // Background color
                                    ),
                                    label: const Text("Gallery",style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container))),
                              ],
                            ),
                          ),
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
                    if (_formKey.currentState!.validate() && file1 != null) {
                      _formKey.currentState!.save();
                      uploadFile(file1);
                    } else {
                      print("error");
                      const message = 'Enter the every data';
                      const snackbar =
                          const SnackBar(content: const Text(message));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },

                  icon: const Icon(Icons.add,color: Palette.basic,),
                  label: const Text('Add question',style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.basic)),
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

    setState(() => file1 = File(path));
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

    setState(() => file1 = File(path));
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
                style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.lightbasic),
              );
            } else {
              return Text(
                '$percentage %',
                  style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.lightbasic),
              );
            }
          } else {
            return Container();
          }
        },
      );

  Future uploadFile(image1) async {
    if (image1 == null) return;
    final fileName1 = basename(image1!.path);
    final destination1 = 'Images/$fileName1';
    task2 = DB.uploadFile(destination1, image1!);
    setState(() {});
    if (task2 == null) return;
    final snapshot2 = await task2!.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();
    setState(() {
      image2url = urlDownload2;
    });
    DB().Addquestion(
        question: qest,
        op1: op1,
        op2: op2,
        op3: op3,
        op4: op4,
        ans: selectedAns,
        docid: widget.id,
        url: image2url,
        desc: desc);
  }
}

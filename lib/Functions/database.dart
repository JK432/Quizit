import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Quiz {
  String id;
  String title;
  String desc;
  Quiz({
    this.id = "",
    this.title = "",
    this.desc = "",
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
      };
  static Quiz fromJson(Map<String, dynamic> Json) => Quiz(
        id: Json['id'],
        desc: Json['desc'],
        title: Json['title'],
      );
}

class imurlup {
  String imurl;

  imurlup({
    this.imurl = "",

  });

  Map<String, dynamic> toJson() => {
    'imurl': imurl,

  };
  static  imurlup fromJson(Map<String, dynamic> Json) =>  imurlup(

    imurl: Json['imurl'],

  );
}
class Question {
  String id;
  String question;
  String op1;
  String op2;
  String op3;
  String op4;
  int ans;
  String desc;
  String imurl;

  Question({
    this.id = "",
    this.question = "",
    this.op1 = "",
    this.op2 = "",
    this.op3 = "",
    this.op4 = "",
    this.ans = 0,
    this.imurl = "",
    this.desc = "",
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'op1': op1,
        'op2': op2,
        'op3': op3,
        'op4': op4,
        'ans': ans,
        'imurl': imurl,
        'desc': desc,
      };
  static Question fromJson(Map<String, dynamic> Json) => Question(
        id: Json['id'],
        question: Json['question'],
        op1: Json['op1'],
        op2: Json['op2'],
        op3: Json['op3'],
        op4: Json['op4'],
        ans: Json['ans'],
        imurl: Json['imurl'],
        desc: Json['desc'],
      );
}

class DB {
  static UploadTask? uploadFile(String destination, File file) {

    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
Future Deletequestion({required String docid, required id,required String url,})async{
  try{
    Deletefile(url, docid, id);
  }catch(e){}
    final qp = FirebaseFirestore.instance
        .collection("quiz")
        .doc(docid)
        .collection("questions")
        .doc(id);
  try{
    qp.delete();
  }catch(e){}

}
  Future Deletequestioncollection({required String docid})async{

    final qp = FirebaseFirestore.instance
        .collection("quiz")
        .doc(docid);

    try{
      qp.delete();
    }catch(e){}

  }
void Deletefile(String url,String docid,String id)async{
  const baseUrl = "https://firebasestorage.googleapis.com/v0/b/quizeit-639d0.appspot.com/o/";
  String imagePath = url.replaceAll(baseUrl,"");
  int indexOfEndPath = imagePath.indexOf("?");
  imagePath = imagePath.substring(0,indexOfEndPath);
  imagePath = imagePath.replaceAll("%2F","/");
  print(imagePath);
  try{
    final ref = FirebaseStorage.instance.ref(imagePath);
    ref.delete();
  }on FirebaseException catch (e) {
    return null;
  }
  final qp = FirebaseFirestore.instance
      .collection("quiz")
      .doc(docid)
      .collection("questions")
      .doc(id);
  final up=imurlup(
      imurl: "No images");
  final json = up.toJson();
  await qp.update(json).then((value) => null);
  }

  Future Createquiz({required String title, required String desc}) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    final quiz = FirebaseFirestore.instance.collection("quiz").doc(id);
    final quiz1 = Quiz(
      title: title,
      desc: desc,
      id: id,
    );
    final json = quiz1.toJson();
    await quiz.set(json).then((value) => null);
  }

  Future Addquestion(
      {required String question,
      required String op1,
      required String op2,
      required String op3,
      required String op4,
      required int ans,
      required String docid,
      required String url,
      required String desc}) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final qp = FirebaseFirestore.instance
        .collection("quiz")
        .doc(docid)
        .collection("questions")
        .doc(id);
    final qp1 = Question(
      id: id,
      question: question,
      op1: op1,
      op2: op2,
      op3: op3,
      op4: op4,
      ans: ans,
      imurl: url,
      desc: desc,
    );
    final json = qp1.toJson();
    await qp.set(json).then((value) => null);
  }


Future updatequest({
  required String question,
  required String op1,
  required String op2,
  required String op3,
  required String op4,
  required int ans,
  required String docid,
  required String url,
  required String desc,
  required id,}) async {
  final qp = FirebaseFirestore.instance
      .collection("quiz")
      .doc(docid)
      .collection("questions")
      .doc(id);
  final qp1 = Question(
    id: id,
    question: question,
    op1: op1,
    op2: op2,
    op3: op3,
    op4: op4,
    ans: ans,
    imurl: url,
    desc: desc,
  );
  final json = qp1.toJson();
  await qp.update(json).then((value) => null);

}
  Stream<List<Quiz>> readQuiz() =>
      FirebaseFirestore.instance.collection('quiz').snapshots().map((snaphot) =>
          snaphot.docs.map((doc) => Quiz.fromJson(doc.data())).toList());
  Stream<List<Question>> readQuestion(String docid) => FirebaseFirestore
      .instance
      .collection('quiz')
      .doc(docid)
      .collection('questions')
      .snapshots()
      .map((snaphot) =>
          snaphot.docs.map((doc) => Question.fromJson(doc.data())).toList());
}

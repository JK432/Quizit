import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizit/Functions/colorfunction.dart';
import 'package:quizit/Functions/database.dart';
import 'package:quizit/Screens/ground.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

String Title = "";
String dics = "";

class _HomeState extends State<Home> {
  final formGlobalKey = GlobalKey<FormState>();
  Widget appBarTitle = const Text(
    "Select a Quiz",
   style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Palette.container ,
  );
  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text(
          "Cancel",
          style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = ElevatedButton(
        style: ElevatedButton.styleFrom(primary:Palette.container),
        child: const Text(
          "Continue",
            style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.basic),
        ),
        onPressed: () async {
          if (formGlobalKey.currentState!.validate()) {
            formGlobalKey.currentState!.save();
            await DB()
                .Createquiz(title: Title, desc: dics)
                .then((value) => Navigator.of(context).pop());
          }
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor:Palette.darkbasic,

        title: const Text(
          "Add Quiz",
          style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container),
        ),
        content: Container(
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Palette.container,
                  decoration: InputDecoration(
                    //focusedBorder:

                    focusColor: Palette.container,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.container),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Title",
                    labelStyle: const TextStyle(color: Palette.container),
                  ),
                  style: const TextStyle(
                    color: Palette.container,
                    //backgroundColor:
                  ),
                  validator: (title) {
                    if (title!.isNotEmpty) {
                      setState(() {
                        Title = title;
                      });
                      return null;
                    } else
                      return 'Please enter a title';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Palette.container,
                  style: const TextStyle(
                    color: Palette.container,
                    //backgroundColor:
                  ),
                  decoration: InputDecoration(
                    hoverColor: Palette.container,
                    fillColor: Palette.container,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.container),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Discription",
                    labelStyle: const TextStyle(color: Palette.container),
                  ),
                  validator: (disc) {
                    if (disc != null && disc.isNotEmpty) {
                      setState(() {
                        dics = disc!;
                      });
                      return null;
                    } else {
                      setState(() {
                        disc = "Some discription";
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      backgroundColor: Palette.darkbasic,
      appBar: AppBar(
        backgroundColor: Palette.basic,
          elevation: 0.0,
          title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon = const Icon(
                  Icons.close,
                  color: Palette.container,
                );
                appBarTitle = const TextField(
                  autofocus: true,
                  cursorColor: Palette.container,
                  style: TextStyle(
                    color: Palette.container,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Palette.container),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Palette.container)),
                );
              } else {
                actionIcon = const Icon(
                  Icons.search,
                  color: Palette.container,
                );
                appBarTitle = const Text(
                  "Select a Quiz",
                  style: TextStyle(fontStyle: FontStyle.italic,fontWeight:FontWeight.bold,color: Palette.container),
                );
              }
            });
          },
        ),
      ]),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: StreamBuilder<List<Quiz>>(
          stream: DB().readQuiz(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final quiz = snapshot.data;
              if(quiz==null || quiz.isEmpty){

                return Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(

                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Thankyou for using this App.You can create a question collection by taping the + icon below, After that add your questions",  style: TextStyle(
                              fontStyle: FontStyle.italic,

                              fontWeight: FontWeight.bold,
                              color: Palette.container),),
                          SizedBox(height: 100,),
                          Center(child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Palette.hardprimary,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              height: 150,
                              width: 145,
                              child: IconButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 60,
                                  color: Palette.basic,
                                ),
                              ),
                            ),
                          ),)
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Container(
                  decoration: const BoxDecoration(color: Palette.darkbasic),
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Palette.hardprimary,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              height: 150,
                              width: 145,
                              child: IconButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 60,
                                  color: Palette.basic,
                                ),
                              ),
                            ),
                          )
                        ] +
                            quiz.map(buildQuiz).toList(),
                      ),
                    ),
                  ),
                );
              }

            }

            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(color: Palette.hardprimary),
              );
            } else {
              return const Center(
                child:CircularProgressIndicator(color: Palette.hardprimary),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildQuiz(Quiz quiz) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Ground(
                          title: quiz.title,
                          desc: quiz.desc,
                          id: quiz.id,
                        )));
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            height: 150,
            width: 145,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height:20),
                    Center(
                      child: Text(
                        quiz.title.length>20?quiz.title.substring(0,19)+"...":quiz.title,
                        overflow:TextOverflow.fade,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontStyle:FontStyle.italic,fontSize: 25,color: Palette.basic),
                      ),
                    ),

                    const SizedBox(height: 8,),
                    Text(
                        quiz.desc.length>30?quiz.desc.substring(0,29)+"...":quiz.desc,
                        overflow:TextOverflow.fade,
                      style: const TextStyle(fontStyle:FontStyle.italic, fontSize: 18,color: Palette.sub),),

                  ],
                ),

            ),
          ),
        ),
      );
}

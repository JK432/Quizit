import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizit/Functions/colorfunction.dart';
import 'package:quizit/Screens/addquiz.dart';
import '../Functions/database.dart';
import 'editquiz.dart';

class Ground extends StatefulWidget {
  final title;
  final id;
  final desc;
  const Ground({this.title, this.desc, this.id});
  @override
  _GroundState createState() => _GroundState();
}

String showdesc = "";
bool deletable=false;
class _GroundState extends State<Ground> {
  int aValue1 = 0;
  int aValue2 = 0;
  int aValue3 = 0;
  int aValue4 = 0;
  Color Colorplate = Palette.secondary;
  String selectedq1 = "";
  String selectedq2 = "";
  String selectedq3 = "";
  String selectedq4 = "";

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {

      // set up the button
      Widget okButton =  ElevatedButton(
          onPressed: () {Navigator.of(context).pop();},
          child: Text("Ok")

      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor: Palette.darkbasic,
        title: Text("Sorry!", style: TextStyle(
            fontStyle: FontStyle.italic,

            fontWeight: FontWeight.bold,
            color: Palette.container)),
        content: Text("Empty collection can only be deleted so please delete every question first. We are working on this bug and will be fixed on next update.", style: TextStyle(
            fontStyle: FontStyle.italic,

            fontWeight: FontWeight.bold,
            color: Palette.lightbasic)),
        actions: [
          okButton,
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: (){
                  if(deletable){
                    DB().Deletequestioncollection(docid: widget.id);
                    Navigator.of(context).pop();
                  }else{
                    showAlertDialog(context);
                  }

                  //DB().Deletequestion(docid: widget.id, id:  widget.quiz.id, url:  widget.quiz.imurl);
                 },
                  // child: Icon(Icons.delete_outline,color: Palette.basic,),

                  child: const Text("Delete", style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Palette.basic))

            ),
          )
        ],
        backgroundColor: Palette.basic,
        title: const Text(
          "Choose your answers.",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Palette.container),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Palette.container),
      ),
      body: StreamBuilder<List<Question>>(
        stream: DB().readQuestion(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final quest = snapshot.data;
            if(quest==null || quest.isEmpty){

                deletable=true;

              return const Center(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Sorry! No question to Answer.You can Add some at that + button below",  style: TextStyle(
                        fontStyle: FontStyle.italic,

                        fontWeight: FontWeight.bold,
                        color: Palette.container),),
                  ),
                ),
              );

            }else{
              deletable=false;
              return Container(

                color: Palette.darkbasic,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: quest.map(buildQuest).toList(),
                    ),
                  ),
                ),
              );

            }



            }

          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Palette.container,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Addquiz(
                        title: widget.title,
                        desc: widget.desc,
                        id: widget.id,
                      )));
        },
        child: const Icon(Icons.add,color: Palette.basic,size: 35,),
      ),
    );
  }

  Widget buildQuest(Question quest) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
        child: Container(
          decoration: BoxDecoration(
              color: Palette.lightbasic,
              borderRadius: BorderRadius.circular(5.2)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 5,
                ),

                Container(
                    decoration: BoxDecoration(
                        color: Palette.secondary,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          quest.question,
                          style: const TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ))),
                const SizedBox(
                  height: 5,
                ),

                //RichText(style: TextStyle(fontSize: 25), text:InlineSpan(quest.question,)),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 2, 5),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedq1 == quest.id
                              ? aValue1 == quest.ans
                                  ? Palette.sucess
                                  : Palette.failure
                              : Palette.options,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Text(
                          quest.op1,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (selectedq1 == quest.id) {
                        } else {
                          selectedq1 = quest.id;
                        }
                        if (selectedq2 == quest.id) {
                        } else {
                          selectedq2 = "";
                        }
                        if (selectedq3 == quest.id) {
                        } else {
                          selectedq3 = "";
                        }
                        if (selectedq4 == quest.id) {
                        } else {
                          selectedq4 = "";
                        }

                        if (quest.ans == 1) {
                          aValue1 = quest.ans;
                          Colorplate = Palette.sucess;
                        } else {
                          Colorplate = Palette.failure;
                          aValue1 = 0;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 2, 5),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedq2 == quest.id
                              ? aValue2 == quest.ans
                                  ? Palette.sucess
                                  : Palette.failure
                              : Palette.options,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Text(
                          quest.op2,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (selectedq1 == quest.id) {
                        } else {
                          selectedq1 = "";
                        }
                        if (selectedq2 == quest.id) {
                        } else {
                          selectedq2 = quest.id;
                        }
                        if (selectedq3 == quest.id) {
                        } else {
                          selectedq3 = "";
                        }
                        if (selectedq4 == quest.id) {
                        } else {
                          selectedq4 = "";
                        }

                        if (quest.ans == 2) {
                          Colorplate = Palette.sucess;
                          aValue2 = quest.ans;
                        } else {
                          Colorplate = Palette.failure;
                          aValue2 = 0;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 2, 5),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedq3 == quest.id
                              ? aValue3 == quest.ans
                                  ? Palette.sucess
                                  : Palette.failure
                              : Palette.options,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Text(
                          quest.op3,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (selectedq1 == quest.id) {
                        } else {
                          selectedq1 = "";
                        }
                        if (selectedq2 == quest.id) {
                        } else {
                          selectedq2 = "";
                        }
                        if (selectedq3 == quest.id) {
                        } else {
                          selectedq3 = quest.id;
                        }
                        if (selectedq4 == quest.id) {
                        } else {
                          selectedq4 = "";
                        }

                        if (quest.ans == 3) {
                          Colorplate = Palette.sucess;
                          aValue3 = quest.ans;
                        } else {
                          Colorplate = Palette.failure;
                          aValue3 = 0;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 2, 5),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedq4 == quest.id
                              ? aValue4 == quest.ans
                                  ? Palette.sucess
                                  : Palette.failure
                              : Palette.options,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Text(
                          quest.op4,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (selectedq1 == quest.id) {
                        } else {
                          selectedq1 = "";
                        }
                        if (selectedq2 == quest.id) {
                        } else {
                          selectedq2 = "";
                        }
                        if (selectedq3 == quest.id) {
                        } else {
                          selectedq3 = "";
                        }
                        if (selectedq4 == quest.id) {
                        } else {
                          selectedq4 = quest.id;
                        }

                        if (quest.ans == 4) {
                          Colorplate = Palette.sucess;
                          aValue4 = quest.ans;
                        } else {
                          Colorplate = Palette.failure;
                          aValue4 = 0;
                        }
                      });
                    },
                  ),
                ),

                const Divider(),
                if (showdesc == quest.id)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quest.imurl==""|| quest.imurl=="No images" ?const Text("No Image Available",style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Palette.basic),):Image.network(quest.imurl,  errorBuilder: (BuildContext context,
                          Object exception,
                          StackTrace? stackTrace) {
                        return const Text('Error loading image...',    style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Palette.lightbasic));
                      },),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quest.desc,
                          style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Palette.basic),
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.basic, // Background color
                        ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Editquiz(
                                    title: widget.title,
                                    desc: widget.desc,
                                    id: widget.id,
                                    quiz: quest,

                                  )));
                        },
                        child: const FaIcon(Icons.edit,color: Palette.container,)),
                    const SizedBox(width: 5,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.basic, // Background color
                        ),
                        onPressed: () {
                          setState(() {
                            if (showdesc == quest.id) {
                              setState(() {
                                showdesc = "";
                              });
                            } else {
                              showdesc = quest.id;
                            }
                          });
                        },

                        child: const Text("Show/Hide Desc",style: TextStyle(color: Palette.container),),),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}

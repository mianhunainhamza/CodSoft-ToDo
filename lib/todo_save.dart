import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo_list/todo.dart';

class TodoSave extends StatefulWidget {
  Todo todo;
  TodoSave({Key?key, required this.todo}) : super(key: key);

  @override
  _TodoSaveState createState() => _TodoSaveState();
}

class _TodoSaveState extends State<TodoSave> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title!;
    descriptionController.text = widget.todo.description!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child:TextField(
                onChanged: (data) {
                  widget.todo.title = data;
                },
                    cursorColor: Colors.black,
                style: GoogleFonts.lato(color: Colors.black,fontSize: 20),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter the title",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold)
                ),
                controller: titleController,
              )),
              const SizedBox(
                height: 25,
              ),
              TextField(
                maxLines: 10,
                onChanged: (data) {
              widget.todo.description = data;
                },
                cursorColor:Colors.black,
                style: GoogleFonts.lato(color: Colors.black,fontSize: 15),
                decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Write a new note"
                ),
                controller: descriptionController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GNav(
                activeColor: Colors.white,
                tabs: [ GButton(
                    onPressed: () {
                      if (descriptionController.text.isNotEmpty)
                        {
                          Navigator.pop(context, widget.todo);
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: CupertinoColors.white,
                              content: Text("Notes are Empty",style: TextStyle(color: Colors.black),)));
                        }
                    },
                    rippleColor: Colors.lightBlueAccent.withOpacity(0.4),
                    hoverColor: Colors.lightBlueAccent.withOpacity(0.4),
                    curve: Curves.easeOutExpo,
                    duration: const Duration(milliseconds: 900),
                    gap: 7,
                    iconSize: MediaQuery.of(context).size.height * 0.041,
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    icon: CupertinoIcons.add,
                    text: 'ADD'
                ),
                ]),
            ]),
      ),
    );
  }
}

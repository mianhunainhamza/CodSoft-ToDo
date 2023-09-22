import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/todo.dart';
import 'package:todo_list/todo_save.dart';

import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  List todos = [];
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    List todoList = jsonDecode(stringTodo!);
    for (var todo in todoList) {
      setState(() {
        todos.add(Todo().fromJson(todo));
      });
    }
  }

  void saveTodo() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: nWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "CodeDo",
          style: GoogleFonts.novaFlat(
            decoration: TextDecoration.none,
            color: Colors.deepPurpleAccent,
            fontSize: 35,
          ),
        ),
      ),
      backgroundColor: nWhite,
      body: Column(
        children: [
          const SizedBox(height: 15,),
           Row(
            children: [
              todos.isEmpty?Container(): Padding(
              padding:const EdgeInsets.only(left: 28.0,top: 20,bottom: 15),
              child: Text(
                "All ToDos",
                style: GoogleFonts.novaFlat(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),]
          ),
          Expanded(
            child: todos.isEmpty? Align(
                alignment:Alignment.center,
                child: Text("So Empty",style:GoogleFonts.lato(
    decoration: TextDecoration.none,
    color: Colors.black,
    fontSize: 16,
    ),)):
            items(height),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            addTodo();
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }

  ListView items(double height) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: height * 0.11,
            child: Card(
              color: CupertinoColors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: CupertinoColors.lightBackgroundGray),
                borderRadius: BorderRadius.circular(25.0),
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 6.0),
              child: InkWell(
                onTap: () async {
                  Todo t = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TodoSave(todo: todos[index])));
                  setState(() {
                    todos[index] = t;
                  });
                  saveTodo();
                },
                child: makeListTile(todos[index], index),
              ),
            ),
          );
        });
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoSave(todo: t)));
    setState(() {
      todos.add(returnTodo);
    });
    saveTodo();
  }

  makeListTile(Todo todo, index) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 18.0, vertical: 7.0),
        leading: InkWell(
          onTap: () {
            setState(() {
              todo.status = !todo.status!;
            });
          },
          child: SizedBox(
            height: 33,
            width: 30,
            child: todo.status!
                ? const Icon(
              CupertinoIcons.check_mark_circled_solid,
              size: 28,
              color: Colors.deepPurpleAccent,
            )
                : const Icon(
              CupertinoIcons.check_mark_circled,
              size: 28,
              color: CupertinoColors.black,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              todo.title!,
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration:
                  todo.status! ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ],
        ),
        subtitle: Text(todo.description!,
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 13,
                decoration:
                todo.status! ? TextDecoration.lineThrough : TextDecoration.none)),
        trailing: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 33,
            child: InkWell(
                onTap: () {
                  delete(todo);
                },
                child: const Icon(CupertinoIcons.delete,
                    color: Colors.black, size: 25.0)),
          ),
        ));
  }

  delete(Todo todo) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Alert"),
          content: const Text("Are you sure to delete?"),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Background color
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("No")),
            const SizedBox(
              height: 1,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Background color
                ),
                onPressed: () {
                  setState(() {
                    todos.remove(todo);
                  });
                  Navigator.pop(ctx);
                  saveTodo();
                },
                child: const Text("Yes"))
          ],
        ));
  }
}

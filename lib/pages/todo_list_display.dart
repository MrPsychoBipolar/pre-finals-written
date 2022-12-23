import 'package:flutter/material.dart';
import 'package:pre_finals_written/db_helper/db_helper_todo.dart';
import 'package:pre_finals_written/model/todo_model.dart';
import 'package:pre_finals_written/pages/todoList_formHandling.dart';
import 'package:pre_finals_written/widget/todo_widget.dart';

class ToDoListDisplay extends StatefulWidget {
  const ToDoListDisplay({Key? key}) : super(key: key);

  @override
  State<ToDoListDisplay> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<ToDoListDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ToDoListFormHandling()));
            setState(() {});
          },
          backgroundColor: Colors.lightGreenAccent,
          child: const Icon(Icons.add, color: Colors.black),
        ),
        body: FutureBuilder<List<ToDo>?>(
          future: ToDoDataBaseHelper.getAllToDo(),
          builder: (context, AsyncSnapshot<List<ToDo>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => ToDoWidget(
                    todo: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ToDoListFormHandling()));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                  topRight: Radius.elliptical(60, 40),
                                  bottomLeft: Radius.elliptical(60, 40))),
                              backgroundColor: Colors.lightGreenAccent,
                              title: const Text(
                                  'Are you sure you want to delete this Task?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await ToDoDataBaseHelper.deleteTodo(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No Task yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

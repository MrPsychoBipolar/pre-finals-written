import 'package:flutter/material.dart';
import 'package:pre_finals_written/db_helper/db_helper_todo.dart';
import 'package:pre_finals_written/model/todo_model.dart';

class ToDoListFormHandling extends StatelessWidget {
  final ToDo? todo;

  const ToDoListFormHandling({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if(todo != null){
      titleController.text = todo!.title;
      descriptionController.text = todo!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  'input your task',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: titleController,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    labelText: 'Todo title',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Description',
                  labelText: 'Description of your task',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                height: 25,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = titleController.value.text;
                    final description = descriptionController.value.text;

                    if (title.isEmpty || description.isEmpty) {
                      return;
                    }

                    final ToDo model = ToDo(
                        title: title, description: description, id: todo?.id);

                    if (todo == null) {
                      await ToDoDataBaseHelper.addTodo(model);
                    } else {
                      await ToDoDataBaseHelper.updateToDo(model);
                    }

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blue,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )))),
                  child: Text(
                    todo == null ? 'Save' : 'Edit',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

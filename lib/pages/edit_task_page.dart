import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/models/add_task_request_model.dart';
import 'package:flutter_tasklist_app/pages/home_page.dart';
import 'package:flutter_tasklist_app/data/models/task_response_model.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.attributes.title;
    descriptionController.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: const Color(0xFF4C53A5),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
              backgroundColor: const Color(0xFF4C53A5),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final newModel = AddTaskRequestModel(
                data: Data(
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
              try {
                await TaskRemoteDatasource().updateTask(widget.task.id, newModel);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update task: $e')),
                );
              }
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}

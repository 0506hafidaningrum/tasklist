import 'package:flutter/material.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/models/task_response_model.dart';
import 'package:flutter_tasklist_app/pages/edit_task_page.dart';
import 'package:flutter_tasklist_app/pages/home_page.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    super.key,
    required this.task,
  });

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Task',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: const Color(0xFF4C53A5),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          Text('Title: ${widget.task.attributes.title}'),
          const SizedBox(height: 16),
          Text('Description: ${widget.task.attributes.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: const Color(0xFF4C53A5),
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditTaskPage(task: widget.task);
                  }));
                },
                child: const Text('Edit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              try {
                                await TaskRemoteDatasource().deleteTask(widget.task.id);
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              } catch (e) {
                                Navigator.of(context).pop(); // Close the dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete task: $e'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Delete hafida'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

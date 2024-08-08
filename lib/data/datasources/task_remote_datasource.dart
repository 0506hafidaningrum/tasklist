import 'dart:convert'; // Tambahkan impor ini jika belum ada
import 'package:flutter_tasklist_app/data/models/add_task_request_model.dart';
import 'package:flutter_tasklist_app/data/models/add_task_response_model.dart';
import 'package:flutter_tasklist_app/data/models/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDatasource {
  Future<TaskResponseModel> getTasks() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/tasks'),
    );
    if (response.statusCode == 200) {
      return TaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/tasks'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data.toJson()), // Gunakan jsonEncode untuk mengonversi objek menjadi JSON
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/api/tasks/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> updateTask(String id, AddTaskRequestModel newModel) async {
    final response = await http.patch(
      Uri.parse('http://localhost:3000/api/tasks/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newModel.toJson()), // Gunakan jsonEncode untuk mengonversi objek menjadi JSON
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }
}

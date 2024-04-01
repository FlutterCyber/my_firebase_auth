import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/student.dart';

class RTDBService {
  static void createData({required Student student}) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('students').push().set(student.toJson());
    print("Stored Succesfully");
  }

  static Future<List<Student>> readData() async {
    List<Student> students = [];
    /// firebasedan ma'lumotni olib kelish
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    Query _query = databaseReference.ref.child("students");
    DatabaseEvent event = await _query.once();
    DataSnapshot data = event.snapshot;
    /// olib kelingan ma'lumotlarni listga o'rkazish
    for (var child in data.children) {
      var myJson = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(myJson);
      Student student = Student.fromJson(map);
      students.add(student);
    }
    return students;
  }

  Future<void> updateData(Student student, var studentKey) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference
        .child('students')
        .child(studentKey)
        .update(student.toJson());
    print('Student updated successfully');
  }

  Future<void> deleteData(String studentId) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child('students').child(studentId).remove();
    print('Student deleted successfully');
  }
}

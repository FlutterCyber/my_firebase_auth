import 'package:flutter/material.dart';
import 'package:my_firebase_auth/model/student.dart';
import 'package:my_firebase_auth/pages/home_page.dart';
import 'package:my_firebase_auth/service/rtdb_service.dart';

class PostPage extends StatefulWidget {
  static const String id = "post_page";

  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController facultyController = TextEditingController();

  void _post() {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    int course = int.parse(courseController.text.trim());
    String faculty = facultyController.text.trim();
    Student student = Student(
      firstName: firstName,
      lastName: lastName,
      course: course,
      faculty: faculty,
    );
    RTDBService.createData(student: student);

    makeFieldsEmpty();
  }

  void makeFieldsEmpty() {
    firstNameController.clear();
    lastNameController.clear();
    courseController.clear();
    facultyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.id);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
        title: const Text(
          "Post student info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(hintText: "FirstName"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(hintText: "LastName"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: courseController,
              decoration: InputDecoration(hintText: "Course"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: facultyController,
              decoration: InputDecoration(hintText: "Faculty"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  _post();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

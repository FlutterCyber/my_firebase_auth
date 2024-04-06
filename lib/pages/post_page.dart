import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:my_firebase_auth/model/student.dart';
import 'package:my_firebase_auth/pages/home_page.dart';
import 'package:my_firebase_auth/service/image_picker_service.dart';
import 'package:my_firebase_auth/service/rtdb_service.dart';
import 'package:my_firebase_auth/service/storage_service.dart';

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
  File? image;
  var logger = Logger();
  bool isUploading = true;

  void _post() async {
    setState(() {
      isUploading = false;
    });
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    int course = int.parse(courseController.text.trim());
    String faculty = facultyController.text.trim();
    String imageUrl = await uploadImage();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        course != null &&
        faculty.isNotEmpty) {
      if (imageUrl.isNotEmpty) {
        Student student = Student(
          firstName: firstName,
          lastName: lastName,
          course: course,
          faculty: faculty,
          imageUrl: imageUrl,
        );
        RTDBService.createData(student: student);

        makeFieldsEmpty();
        setState(() {
          isUploading = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rasm yuklanmadi')),
        );
        return;
      }
    }
  }

  void makeFieldsEmpty() {
    firstNameController.clear();
    lastNameController.clear();
    courseController.clear();
    facultyController.clear();
  }

  void pickImage() {
    ImagePickerService.pickImagefromGallery().then((_image) => {
          setState(() {
            image = File(_image!.path);
          }),
        });
  }

  Future<String> uploadImage() async {
    String? imageUrl =
        await StorageService.uploadImageToFirebase(imageFile: image!);
    return imageUrl!;
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
        child: Stack(
          children: [
            ListView(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: const Icon(Icons.attach_file)),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: image != null
                            ? Image.file(image!)
                            : Image.asset("assets/images/defaultImage.png")),
                  ],
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            isUploading
                ? const SizedBox.shrink()
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

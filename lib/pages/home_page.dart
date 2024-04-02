import 'package:flutter/material.dart';
import 'package:my_firebase_auth/pages/post_page.dart';
import 'package:my_firebase_auth/service/rtdb_service.dart';
import '../model/student.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> items = [];
  List<String> studentIds = [];

  void getData() async {
    items.clear();
    studentIds.clear();
    RTDBService.readData().then((map) => {
          setState(() {
            map!.forEach((key, value) {
              studentIds.add(key);
              items.add(value);
            });
          }),
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Students info",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, PostPage.id);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              getData();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemsOfList(items[index], studentIds[index]);
            }),
      ),
    );
  }

  Widget itemsOfList(Student student, String id) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${student.firstName}, ${student.lastName}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                student.faculty,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                student.course.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "id: $id",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  RTDBService.deleteData(id);
                  //getData();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

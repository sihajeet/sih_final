import 'package:flutter/material.dart';
import 'package:sih_final/pages/askquestion/askquestion.dart';
import 'package:sih_final/pages/employee/emplyee.dart';
import 'package:sih_final/pages/subject/subject.dart';

import '../researchScholor/research.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
        ],
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GridView(
                physics:
                    const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 3
                          : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: (2 / 2.5),
                ),
                children: [
                  homeCard(
                    icon: Icons.menu_book_rounded,
                    title: "Subjects",
                    onpress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SubjectScreen(),
                      ),
                    ),
                  ),
                  homeCard(
                    icon: Icons.assistant,
                    title: "Ask Question",
                    onpress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AskQuestionScreen(),
                      ),
                    ),
                  ),
                  homeCard(
                    icon: Icons.engineering,
                    title: "Employee",
                    onpress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const EmployeScreen(),
                      ),
                    ),
                  ),
                  homeCard(
                    icon: Icons.person,
                    title: "Research Scholar",
                    onpress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ResearchPage(),
                      ),
                    ),
                  ),
                  homeCard(
                      icon: Icons.menu_book_rounded,
                      title: "Community",
                      onpress: () {}),
                  homeCard(
                      icon: Icons.chat_bubble_outlined,
                      title: "Chat-Bot",
                      onpress: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector homeCard(
      {required String title,
      required IconData icon,
      required VoidCallback onpress}) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                  0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeScreen extends StatefulWidget {
  const EmployeScreen({super.key});

  @override
  State<EmployeScreen> createState() => _EmployeScreenState();
}

class _EmployeScreenState extends State<EmployeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employments'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const MyCustomListTile(
            title: "Job Title",
            subtitle: "Job description",
            iconData: Icons.engineering,
          );
        },
      ),
    );
  }
}

class MyCustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData; // For avatar image
  final Color? textColor; // For title and subtitle color

  const MyCustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: const Color.fromARGB(255, 162, 211, 252),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 1, 105, 190)])),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            )),
        title: Text(
          title,
          style: TextStyle(
              color: textColor ?? Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: textColor ?? Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      ),
    );
  }
}

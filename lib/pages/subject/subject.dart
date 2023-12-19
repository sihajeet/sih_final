import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../videoPlayer/video.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  Future<List<Map<String, dynamic>>> engLecture() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/english.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> mathLecture() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/maths.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> phyLecture() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/physics.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> compLecture() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/computer.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> cheLecture() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/chemistry.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF0FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 1,
        title: const Text(
          "Subject",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SubjectTile(title: "English", future: engLecture()),
            SubjectTile(title: "Math", future: mathLecture()),
            SubjectTile(title: "Chemistry", future: cheLecture()),
            SubjectTile(title: "Physics", future: phyLecture()),
            SubjectTile(title: "Computer", future: compLecture()),
          ],
        ),
      ),
    );
  }
}

class SubjectTile extends StatelessWidget {
  const SubjectTile({
    super.key,
    required this.title,
    required this.future,
  });
  final String title;
  final Future<List<Map<String, dynamic>>> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lectures = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lectures.length,
                    itemBuilder: (context, index) {
                      final lecture = lectures[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => YtPlayer(url: lecture['img']),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: 140,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl:
                                        "https://i.ytimg.com/vi/${lecture['img']}/maxresdefault.jpg",
                                    width: double.maxFinite,
                                    fit: BoxFit.contain,
                                    height: 100,
                                    maxHeightDiskCache: 100,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.grey[300],
                                              width: double.maxFinite,
                                              height: 100,
                                            )),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                        color: const Color(0xFFEAF0FF),
                                        child: Center(
                                          child: Text(
                                            lecture['title'],
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  lecture['title'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "product",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

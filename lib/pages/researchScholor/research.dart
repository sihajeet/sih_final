import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sih_final/pages/videoPlayer/video.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResearchPage extends StatefulWidget {
  const ResearchPage({super.key});

  @override
  State<ResearchPage> createState() => _ResearchPageState();
}

class _ResearchPageState extends State<ResearchPage> {
  Future<List<Map<String, dynamic>>> getLecturesData() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/research.json');
    final data = json.decode(jsonString) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Research"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getLecturesData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lectures = snapshot.data!;
            return ListView.builder(
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                final lecture = lectures[index];
                debugPrint(lecture['url']);
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => YtPlayer(url: lecture['img']),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.8,
                              offset: Offset(2, 5))
                        ]),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            imageUrl:
                                "https://i.ytimg.com/vi/${lecture['img']}/maxresdefault.jpg",
                            // imageUrl: 'https://i.ytimg.com/vi/9ZsubirAEsQ/maxresdefault.jpg',
                            width: double.maxFinite,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300],
                                  width: double.maxFinite,
                                  height: 100,
                                )),
                            errorWidget: (context, url, error) {
                              return Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          lecture['title'],
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(lecture['title']),
                //   subtitle: Text(lecture['url']),
                // );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

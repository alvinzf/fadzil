import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:tugas/screens/chara.dart';
import 'package:tugas/screens/detail_chara.dart';

/// This is the main application widget.
Future<List<Chara>> fetchChara(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://my-json-server.typicode.com/ferzuna/api_chara/character'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseChara(response.body);
}

// A function that converts a response body into a List<Photo>.
List<Chara> parseChara(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Chara>((json) => Chara.fromJson(json)).toList();
}

/// This is the stateless widget that the main application instantiates.
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Chara> futureChara;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Chara>>(
        future: fetchChara(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(chara: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.chara}) : super(key: key);

  final List<Chara> chara;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: chara.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailChara(
                            id: chara[index].id,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  chara[index].images,
                  scale: 2.5,
                ),
                Padding(
                  padding: new EdgeInsets.all(10),
                ),
                Text(
                  chara[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:unsplash_gallery/models/photo.dart';
import 'package:unsplash_gallery/utils/constants.dart';

import '../services/photo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> _isLiked = List<bool>.filled(10, false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> _photos = PhotoService().getPhotos();

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
            const SliverAppBar(
              elevation: 5,
              centerTitle: true,
              title: Text(
                "Photo Gallery",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
          ],
          body: FutureBuilder<List<dynamic>>(
              future: _photos,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          tileColor: Colors.blue[50],
                          leading: Image(
                            image: NetworkImage(
                                snapshot.data![index].thumbnailUrl ??
                                    DEFAULT_THUMB),
                          ),
                          title: Text(snapshot.data![index].name ?? ""),
                          subtitle: Text(snapshot.data![index].surname ?? ""),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                  '${_isLiked[index] ? "You and" : ""} ${snapshot.data![index].likes}'),
                              const SizedBox(width: 5),
                              GestureDetector(
                                child: Icon(
                                  _isLiked[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _isLiked[index]
                                      ? Colors.redAccent
                                      : Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    _isLiked[index] = !_isLiked[index];
                                  });
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('detail',
                                arguments: snapshot.data![index] as Photo);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error!'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}

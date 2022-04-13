import 'package:flutter/material.dart';
import 'package:unsplash_gallery/models/photo.dart';
import 'package:unsplash_gallery/services/photo_service.dart';

class SearchPhotosView extends StatefulWidget {
  const SearchPhotosView({Key? key}) : super(key: key);

  @override
  State<SearchPhotosView> createState() => _SearchPhotosViewState();
}

class _SearchPhotosViewState extends State<SearchPhotosView> {
  final TextEditingController _controller = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> _photos = PhotoService().searchByName(_searchText);
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search for a photo',
              prefixIcon: Icon(Icons.search),
            ),
            controller: _controller,
            onChanged: (query) {
              final result = query.trim();
              if (mounted) {
                setState(() {
                  _searchText = result;
                });
              }
            },
          ),
          FutureBuilder<List<dynamic>>(
              future: _photos,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 200,
                    // flex: snapshot.data!.length > 5 ? 1 : 0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name ?? ""),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('detail',
                                arguments: snapshot.data![index] as Photo);
                          },
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error!'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

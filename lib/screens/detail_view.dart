import 'package:flutter/material.dart';
import 'package:unsplash_gallery/models/photo.dart';
import 'package:unsplash_gallery/utils/constants.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.photoItem}) : super(key: key);

  final Photo photoItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          (photoItem.name ?? "") + ' ' + (photoItem.surname ?? ""),
          style: const TextStyle(
              fontSize: 28, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[100],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Image.network(
              (photoItem.url ?? DEFAULT_IMAGE),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

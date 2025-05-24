import 'package:flutter/material.dart';
import 'package:flutter_lab_assignment_3/data/models/album_model.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final VoidCallback? onTap;

  const AlbumTile({
    super.key,
    required this.album,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
      subtitle: Text('Album ID: ${album.id}'),
      onTap: onTap,
    );
  }
}

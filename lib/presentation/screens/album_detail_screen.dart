import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_bloc.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_event.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_state.dart';
import 'package:flutter_lab_assignment_3/data/models/photo_model.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;

  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(FetchPhotosByAlbumId(widget.albumId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotosLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final Photo photo = state.photos[index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          photo.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

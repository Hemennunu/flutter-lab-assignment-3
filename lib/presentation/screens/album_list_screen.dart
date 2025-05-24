import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_bloc.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_event.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_state.dart';
import 'package:flutter_lab_assignment_3/presentation/widgets/album_tile.dart';
import 'package:flutter_lab_assignment_3/router/app_router.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumsLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return AlbumTile(
                  album: album,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.albumDetail,
                      arguments: album.id,
                    );
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }
}

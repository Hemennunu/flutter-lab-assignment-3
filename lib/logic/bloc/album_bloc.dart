import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/data/repository/album_repository.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_event.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_state.dart';
import 'package:flutter_lab_assignment_3/data/models/photo_model.dart';


class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc({required this.repository}) : super(AlbumInitial()) {
    on<FetchAlbums>(_onFetchAlbums);
    on<FetchPhotosByAlbumId>(_onFetchPhotosByAlbumId);
  }

  Future<void> _onFetchAlbums(FetchAlbums event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await repository.fetchAlbums();

      // Fetch the first photo for each album
      final Map<int, Photo> albumPhotos = {};
      for (var album in albums) {
        final photos = await repository.fetchPhotosByAlbumId(album.id);
        if (photos.isNotEmpty) {
          albumPhotos[album.id] = photos.first;
        }
      }

      emit(AlbumsLoaded(albums, albumPhotos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> _onFetchPhotosByAlbumId(FetchPhotosByAlbumId event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final photos = await repository.fetchPhotosByAlbumId(event.albumId);
      emit(PhotosLoaded(photos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}

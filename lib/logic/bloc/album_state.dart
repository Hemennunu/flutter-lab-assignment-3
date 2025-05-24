import 'package:flutter_lab_assignment_3/data/models/album_model.dart';
import 'package:flutter_lab_assignment_3/data/models/photo_model.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<Album> albums;
  final Map<int, Photo> albumPhotos; // albumId -> first Photo

  AlbumsLoaded(this.albums, this.albumPhotos);
}

class PhotosLoaded extends AlbumState {
  final List<Photo> photos;

  PhotosLoaded(this.photos);
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);
}

import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class FetchAlbums extends AlbumEvent {}

class FetchPhotosByAlbumId extends AlbumEvent {
  final int albumId;

  const FetchPhotosByAlbumId(this.albumId);

  @override
  List<Object> get props => [albumId];
}

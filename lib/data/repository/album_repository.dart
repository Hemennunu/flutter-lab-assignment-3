import 'dart:convert';
import 'package:flutter_lab_assignment_3/core/utils/http_client.dart';
import 'package:flutter_lab_assignment_3/data/models/album_model.dart';
import 'package:flutter_lab_assignment_3/data/models/photo_model.dart';

class AlbumRepository {
  final HttpClient httpClient;

  AlbumRepository({required this.httpClient});

  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    final response = await httpClient.get('$_baseUrl/albums');

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> fetchPhotosByAlbumId(int albumId) async {
    final response = await httpClient.get('$_baseUrl/photos?albumId=$albumId');

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos for album $albumId');
    }
  }
}

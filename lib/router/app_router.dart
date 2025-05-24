import 'package:flutter/material.dart';
import 'package:flutter_lab_assignment_3/presentation/screens/album_list_screen.dart';
import 'package:flutter_lab_assignment_3/presentation/screens/album_detail_screen.dart';



class AppRoutes {
  static const String albumList = '/';
  static const String albumDetail = '/albumDetail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case albumList:
        return MaterialPageRoute(builder: (_) => const AlbumListScreen());

      case albumDetail:
        final albumId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AlbumDetailScreen(albumId: albumId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}



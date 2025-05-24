import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab_assignment_3/core/utils/http_client.dart';
import 'package:flutter_lab_assignment_3/data/repository/album_repository.dart';
import 'package:flutter_lab_assignment_3/logic/bloc/album_bloc.dart';
import 'package:flutter_lab_assignment_3/router/app_router.dart';

void main() {
  final httpClient = HttpClient();
  final albumRepository = AlbumRepository(httpClient: httpClient);

  runApp(MyApp(albumRepository: albumRepository));
}

class MyApp extends StatelessWidget {
  final AlbumRepository albumRepository;

  const MyApp({super.key, required this.albumRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(repository: albumRepository),
      child: MaterialApp(
        title: 'Flutter Album App',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.albumList,
      ),
    );
  }
}

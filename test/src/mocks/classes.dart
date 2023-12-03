import 'package:desafio_tecnico_2/src/repositories/api/epub_repository.dart';
import 'package:desafio_tecnico_2/src/repositories/local/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

class LocalStorageMock extends Mock implements LocalStorageHive {}

class EpubRepositoryMock extends Mock implements EpubRepositoryImpl {}

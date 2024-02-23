import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/data/response/search_repositories_response.dart';

//TODO enter your get hub access tokens
const token = "";

@LazySingleton()
class GitHubRepositoryApi {
  final Dio dio = Dio();

  GitHubRepositoryApi() {
    dio.options = BaseOptions(
      baseUrl: 'https://api.github.com/',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
        'accept': 'application/json',
      },
    );
  }

  Future<Either<Exception, SearchRepositoriesResponse>> searchRepositories(
    String searchValue,
  ) async {
    return await handleResponse<SearchRepositoriesResponse>(
      () async {
        var response = await dio.get(
          '/search/repositories',
          queryParameters: {
            'q': searchValue,
            'per_page' : 16,
          },
        );

        response.data;

        return SearchRepositoriesResponse.fromJson(response.data);
      },
    );
  }

  Future<Either<Exception, ResponseType>> handleResponse<ResponseType>(
    Future<ResponseType> Function() request,
  ) async {
    try {
      return Right(await request());
    } on Exception catch (exception) {
      return Left(exception);
    }
  }
}

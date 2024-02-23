import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_repositories_response.freezed.dart';
part 'search_repositories_response.g.dart';

@freezed
class SearchRepositoriesResponse with _$SearchRepositoriesResponse {
  const factory SearchRepositoriesResponse({
    required List<RepositoryResponse> items,
  }) = _SearchRepositoriesResponse;

  factory SearchRepositoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRepositoriesResponseFromJson(json);
}

@freezed
class RepositoryResponse with _$RepositoryResponse {
  const factory RepositoryResponse({
    required int id,
    required String name,
  }) = _RepositoryResponse;

  factory RepositoryResponse.fromJson(Map<String, dynamic> json) =>
      _$RepositoryResponseFromJson(json);
}

import 'dart:convert';

import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/login_response.dart';
import 'package:http/http.dart' as http;

class RenewTokenUseCase extends UseCaseNoParams<LoginResponse> {
  RenewTokenUseCase({required UserRepository repository})
      : super(repository: repository);

  @override
  Future<LoginResponse> call() async {
    final http.Response response =
        await (repository as UserRepository).renewToken();
    switch (response.statusCode) {
      case 200:
        return LoginResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
    }
  }
}

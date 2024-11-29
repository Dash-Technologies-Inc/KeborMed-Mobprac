import 'package:kebormed_mobile/data/network/api_response.dart';
import 'package:kebormed_mobile/data/network/api_service.dart';
import 'package:kebormed_mobile/data/network/api_url.dart';

import '../models/user_model.dart';

class UsersRepository {
  final _apiService = NetworkApiService();

  Future<List<User>> fetchUsers() async {
    final response = await _apiService.getApi(ApiUrl.users);
    return List<User>.from(response.map((x) => User.fromJson(x)));
  }
}

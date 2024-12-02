import 'package:kebormed_mobile/data/network/api_service.dart';
import 'package:kebormed_mobile/data/network/api_url.dart';
import '../models/user_model.dart';

class UsersRepository {
  final _apiService = NetworkApiService();

  //fetching users api call and sort by name
  Future<List<User>> fetchUsers() async {
    final response = await _apiService.getApi(ApiUrl.users);
    var list = List<User>.from(response.map((x) => User.fromJson(x)));
    list.sort((a, b) => a.name!.compareTo(b.name!));
    return list;
  }
}

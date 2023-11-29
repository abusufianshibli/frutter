import 'package:frutter/common/network/api_client.dart';
import 'package:frutter/core/auth/repository/auth_repo.dart';

import '../../common/service/shared_pref.dart';

class AuthRepoImpl implements AuthRepo{
  AuthRepoImpl({
    required RestClient client,
    required SharePref sharePref,
}) : _client = client,
        _sharePref = sharePref;

  final RestClient _client;
  final SharePref _sharePref;

  @override
  Future login()async {
    // TODO: implement login
   await Future.delayed(const Duration(seconds: 3));
    print("from implement");
    return await true;
  }
}
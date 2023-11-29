
import 'package:frutter/core/auth/repository/auth_repo.dart';

import 'package:get_it/get_it.dart';
class LoginUseCase{
  LoginUseCase({required AuthRepo authRepo}):_authRepo=authRepo;

  AuthRepo _authRepo;

  Future<dynamic> call() async{
  return _authRepo.login();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:frutter/core/auth/repository/auth_repo.dart';
import 'package:frutter/core/auth/use_case/login_use_case.dart';
import 'package:frutter/data/auth/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';

import '../../../di/di_service.dart';

class AuthProvider extends ChangeNotifier{

  final _login = di.get<LoginUseCase>();

  Future<bool> loginWithUserName()async{
   final result= await _login.call();
    return result;
}
}
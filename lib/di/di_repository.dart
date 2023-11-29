import 'package:frutter/core/auth/repository/auth_repo.dart';
import 'package:frutter/core/custom_order/repository/custom_order_repository.dart';
import 'package:frutter/data/auth/auth_repo_impl.dart';
import 'package:frutter/data/custom_order/custom_order_impl.dart';

import 'di_service.dart';

Future<void> setupRepositoryModule() async {
  di.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
        client: di(),
        sharePref: di(),
      ));
  di.registerLazySingleton<CustomOrderRepo>(() => CustomOrderRepoImpl(
    client: di(),
    sharePref: di(),
  ));
}


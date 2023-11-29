

import 'package:frutter/core/custom_order/use_case/get_from_use_case.dart';
import 'package:frutter/core/custom_order/use_case/get_search_map_use_case.dart';

import '../core/auth/use_case/login_use_case.dart';
import 'di_service.dart';

Future<void> setUpUseCaseModule() async {
  di.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepo: di()),
  );
  di.registerLazySingleton<GetFromUseCase>(
        () => GetFromUseCase(customOrderRepo: di()),
  );
  di.registerLazySingleton<GetSearchMapUseCase>(
        () => GetSearchMapUseCase(customOrderRepo: di()),
  );
}

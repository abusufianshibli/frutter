
import 'package:dio/dio.dart';

import '../common/network/api_client.dart';
import '../common/network/dio_client.dart';
import '../common/service/interceptors.dart';
import '../common/service/shared_pref.dart';
import '../common/utils/const_string.dart';
import '../data/shared_pref/shared_pref_impl.dart';
import 'di_service.dart';

Future<void> setupServiceModule() async {
  di.registerLazySingleton<SharePref>(() => SharePrefImpl());

  di.registerLazySingleton<RestClient>(
        () => RestClient(
      Dio(
        BaseOptions(
          contentType: "application/json",
          baseUrl: ConstString.baseUrl,
        ),
      )..interceptors.add(
        CustomInterceptors(
          sharePref: di(),
        ),
      ),
    ),
  );

  di.registerLazySingleton<DioClient>(
        () => DioClient(
      Dio(
        BaseOptions(
          contentType: "application/json",
          baseUrl: ConstString.baseUrl,
        ),
      )..interceptors.add(
        CustomInterceptors(
          sharePref: di(),
        ),
      ),
    ),
  );
}



import 'package:get_it/get_it.dart';

import 'di_repository.dart';
import 'di_rest_client.dart';
import 'di_use_casei.dart';

final GetIt di = GetIt.instance;

Future<void> setup() async {
  await setupServiceModule();
  await setupRepositoryModule();
  await setUpUseCaseModule();
}
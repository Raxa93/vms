
import 'package:fu_vms/data/datasources/remote/teacher_db_service.dart';
import 'package:fu_vms/presentation/pages/register/register_vm.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/local/preferences_service.dart';
import 'data/repositories/api_repo/api_repo_imp.dart';
import 'data/repositories/auth_repo/auth_repo.dart';
import 'data/repositories/auth_repo/auth_repo_imp.dart';
import 'data/repositories/teacher_repo/teacher_repo_imp.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {


  locator.registerSingleton<LocalStorageService>(
    await LocalStorageService.getInstance(),
  );

  locator.registerSingleton<TeacherDbServices>(
    await TeacherDbServices.getInstance(),
  );


// Repos
  locator.registerSingleton<AuthRepo>(AuthRepoImp());
  locator.registerSingleton<ApiRepoImp>(ApiRepoImp());
  locator.registerSingleton<TeacherRepoImp>(TeacherRepoImp());

// ViewModels
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
}
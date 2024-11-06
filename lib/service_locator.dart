import 'package:get_it/get_it.dart';
import 'package:smart_iot/data/data_source/auth/auth_firebase_service.dart';
import 'package:smart_iot/data/repository/auth/auth_repo_impl.dart';
import 'package:smart_iot/domain/repository/auth/auth_repo.dart';
import 'package:smart_iot/domain/usecase/auth/signin.dart';
import 'package:smart_iot/domain/usecase/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );
}
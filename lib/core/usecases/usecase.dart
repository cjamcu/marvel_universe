abstract class UseCase<Type, Params> {
  Future<Type> execute(Params params);
}

abstract class BaseUseCase<Type, Params> {
  Type execute(Params params);
}

class NoParams {
  const NoParams();
}

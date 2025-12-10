abstract class UseCase<Input, Output> {
  Output execute(Input input);
}

abstract class UseCaseNoParams<Output> {
  Output execute();
}

abstract class FutureUseCase<Input, Output> {
  Future<Output> execute(Input input);
}

abstract class FutureUseCaseNoParams<Output> {
  Future<Output> execute();
}

abstract class StreamUseCase<Input, Output> {
  Stream<Output> execute(Input input);
}

abstract class StreamUseCaseNoParams<Output> {
  Stream<Output> execute();
}

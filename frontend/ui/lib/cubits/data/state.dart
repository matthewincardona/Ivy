part of 'cubit.dart';

@immutable
class DataState extends Equatable {
  final Data? data;
  final String? message;

  const DataState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

@immutable
class DataDefault extends DataState {}

@immutable
class DataFetchLoading extends DataState {
  const DataFetchLoading() : super();
}

@immutable
class DataFetchSuccess extends DataState {
  const DataFetchSuccess({Data? data}) : super(data: data);
}

@immutable
class DataFetchFailed extends DataState {
  const DataFetchFailed({String? message}) : super(message: message);
}

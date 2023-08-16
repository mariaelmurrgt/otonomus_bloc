part of 'loading_bloc.dart';

final class LoadingState extends Equatable {
  const LoadingState(this.status);

  final AuthStatus status;

  @override
  List<Object> get props => [];
}

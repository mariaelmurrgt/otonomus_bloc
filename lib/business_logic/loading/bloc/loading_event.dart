part of 'loading_bloc.dart';

sealed class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

final class onLoadingCheckUserStatus extends LoadingEvent {
  const onLoadingCheckUserStatus();
}

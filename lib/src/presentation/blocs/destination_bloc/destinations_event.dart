part of 'destinations_bloc.dart';

sealed class DestinationsEvent extends Equatable {
  const DestinationsEvent();

  @override
  List<Object> get props => [];
}

final class GetDestinationsEvent extends DestinationsEvent {}
